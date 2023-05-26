import 'package:administration/src/infra/data_sources/administration_data_source.dart';
import 'package:core/core.dart';

import 'package:drift/drift.dart';
import 'package:internal_database/internal_database.dart';

import '../../domain/errors/administration_errors.dart';

class AdministrationDataSourceInternalImpl implements AdministrationDataSource {
  final AppDatabase _internalDatabase;

  AdministrationDataSourceInternalImpl(this._internalDatabase);

  @override
  Future<int> cancelBill(String id) {
    try {
      final txID = (_internalDatabase.update(_internalDatabase.bill)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        BillCompanion.insert(
          status: BillStatus.canceled,
        ),
      );
      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-cancelBill",
        e,
        e.toString(),
      );
    }
  }

  // TODO change name and modify request to have a status
  Future<int> cancelAllItems(String requestID) {
    try {
      final txID = (_internalDatabase.update(_internalDatabase.item)
            ..where((tbl) => tbl.requestId.equals(requestID)))
          .write(const ItemCompanion(status: Value(ItemStatus.canceled)));
      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-cancelRequest",
        e,
        e.toString(),
      );
    }
  }

  Future<double> getTotalBillPayments(String billID) async {
    try {
      final payments =
          await (_internalDatabase.select(_internalDatabase.payment)
                ..where((tbl) => tbl.billId.equals(billID)))
              .map(PaymentAdapter.convertPayment)
              .get();

      final total = payments.fold(
        0.0,
        (previousValue, element) => previousValue + element.value,
      );

      return total;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getTotalBillPayments",
        e,
        e.toString(),
      );
    }
  }

  Future<int> updateBillStatus(String billID) async {
    final billTotal = await getBillTotal(billID);
    final totalPayment = await getTotalBillPayments(billID);
    // TODO create types for bill mode
    // final bill = await getBill(billID);

    if (totalPayment < billTotal) {
      print(BillStatus.partiallyPaid);
    } else if (totalPayment == billTotal) {
      print(BillStatus.paidWithoutCommission);
    } else {
      print(BillStatus.paid);
    }

    return 0;
  }

  @override
  Future<int> finalizeBill(List<Payment> payments, String billID) async {
    try {
      await Future.wait([
        ...payments
            .map(
              (e) => _internalDatabase
                  .into(_internalDatabase.payment)
                  .insert(PaymentAdapter.createPayment(e, billID)),
            )
            .toList()
      ]);
      return 0;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-cancelBill",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<Bill>> getActiveBills() {
    try {
      final bill = (_internalDatabase.select(_internalDatabase.bill)
            ..where(
              (tbl) => tbl.status.isIn([
                BillStatus.partiallyPaid.index,
                BillStatus.open.index,
                BillStatus.closed.index,
              ]),
            ))
          .map(BillAdapter.convertToBill)
          .get();
      return bill;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getActiveBills",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<Product>> getAllProducts() {
    try {
      final products = _internalDatabase
          .select(_internalDatabase.product)
          .map(ProductAdapter.fromProductData)
          .get();
      return products;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getAllProducts",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<Bill> getBill(String billID) {
    try {
      final bill = (_internalDatabase.select(_internalDatabase.bill)
            ..where((tbl) => tbl.id.equals(billID)))
          .map(BillAdapter.convertToBill)
          .getSingle();
      return bill;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBill",
        e,
        e.toString(),
      );
    }
  }

  Future<Product> getProduct(String productID) {
    try {
      final product = (_internalDatabase.select(_internalDatabase.product)
            ..where((tbl) => tbl.id.equals(productID)))
          .map(ProductAdapter.fromProductData)
          .getSingle();
      return product;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getProduct",
        e,
        e.toString(),
      );
    }
  }

  Future<double> getBillTotal(String billID) async {
    final _query = (_internalDatabase.select(_internalDatabase.request)
          ..where((tbl) => tbl.billId.equals(billID)))
        .join([
      leftOuterJoin(
        _internalDatabase.item,
        _internalDatabase.item.requestId
            .equalsExp(_internalDatabase.request.id),
      )
    ]);

    // ignore: cascade_invocations
    _query.where(
      _internalDatabase.item.status.equals(ItemStatus.preparing.index) |
          _internalDatabase.item.status.equals(ItemStatus.delivered.index),
    );

    final _result = await _query.get();
    final items =
        _result.map((row) => row.readTable(_internalDatabase.item)).toList();

    final total = items.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity),
    );

    return total;
  }

  // TODO
  @override
  Future<List<Request>> getBillValidRequests(String billID) async {
    final _query =
        await (_internalDatabase.select(_internalDatabase.request).join([
      leftOuterJoin(
        _internalDatabase.item,
        _internalDatabase.item.requestId
            .equalsExp(_internalDatabase.request.id),
      )
    ])
              ..where(
                _internalDatabase.bill.id.equals(billID) &
                    _internalDatabase.item.status.isIn([
                      ItemStatus.preparing.index,
                      ItemStatus.delivered.index,
                    ]),
              ))
            .get();

    final requests =
        _query.map((e) => e.readTable(_internalDatabase.request)).toList();
    final items =
        _query.map((e) => e.readTable(_internalDatabase.item)).toList();

    return [];
  }

  @override
  Future<List<Bill>> getLastPaidBills() {
    try {
      final bill = (_internalDatabase.select(_internalDatabase.bill)
            ..where(
              (tbl) => tbl.status.isIn([
                BillStatus.paid.index,
                BillStatus.paidWithoutCommission.index,
              ]),
            )
            ..limit(10))
          .map(BillAdapter.convertToBill)
          .get();
      return bill;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getLastPaidBills",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<Request>> getLastRequests() async {
    final _query =
        await (_internalDatabase.select(_internalDatabase.request).join([
      leftOuterJoin(
        _internalDatabase.item,
        _internalDatabase.item.requestId
            .equalsExp(_internalDatabase.request.id),
      )
    ])
              ..where(
                _internalDatabase.item.status.isNotIn([
                  ItemStatus.canceled.index,
                ]),
              ))
            .get();

    //TODO Review COde
    final requests = _query
        .map(
          (e) => RequestAdapter.fromRequestData(
              e.readTable(_internalDatabase.request), []),
        )
        .toList();
    return requests;
  }

  Future<Item> createItem(NewItem item, String requestID) async {
    try {
      final product = await getProduct(item.productId);
      final createdItem = await _internalDatabase
          .into(_internalDatabase.item)
          .insertReturning(ItemAdapter.createItem(item, product, requestID));

      return ItemAdapter.toItem(createdItem);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-makeRequest",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<Request> createRequest(NewRequest request, String billID) async {
    try {
      final req = await _internalDatabase
          .into(_internalDatabase.request)
          .insertReturning(RequestAdapter.createRequest(request, billID));

      final items = await Future.wait(
        request.items.map((e) => createItem(e, req.id)).toList(),
      );

      return RequestAdapter.fromRequestData(req, items);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-makeRequest",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> setItemDelivered(String id) {
    try {
      final txID = (_internalDatabase.update(_internalDatabase.item)
            ..where((tbl) => tbl.id.equals(id)))
          .write(const ItemCompanion(status: Value(ItemStatus.delivered)));

      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-setItemDelivered",
        e,
        e.toString(),
      );
    }
  }

  Future<int> setAllItemsDelivered(String requestID) {
    try {
      final txID = (_internalDatabase.update(_internalDatabase.item)
            ..where((tbl) => tbl.requestId.equals(requestID)))
          .write(const ItemCompanion(status: Value(ItemStatus.delivered)));

      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-setItemDelivered",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> setRequestDelivered(String requestID) async {
    try {
      final txID = await (_internalDatabase.update(_internalDatabase.request)
            ..where((tbl) => tbl.id.equals(requestID)))
          .write(
        const RequestCompanion(status: Value(RequestStatus.delivered)),
      );
      final _ = await setAllItemsDelivered(requestID);
      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-cancelRequest",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> cancelRequest(String requestID) async {
    try {
      final txID = await (_internalDatabase.update(_internalDatabase.request)
            ..where((tbl) => tbl.id.equals(requestID)))
          .write(
        const RequestCompanion(status: Value(RequestStatus.canceled)),
      );
      final _ = await cancelAllItems(requestID);
      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-cancelRequest",
        e,
        e.toString(),
      );
    }
  }

  // Handle bill Insertion (create or update bill)

  @override
  Future<int> createBill(Bill bill, NewRequest request) async {
    try {
      final bi = await _internalDatabase
          .into(_internalDatabase.bill)
          .insertReturning(BillAdapter.createBill(bill));

      await createRequest(request, bi.id);

      return 0;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-createBill",
        e,
        e.toString(),
      );
    }
  }
}
