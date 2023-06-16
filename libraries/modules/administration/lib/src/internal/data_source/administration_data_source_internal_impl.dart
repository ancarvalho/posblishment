import 'package:administration/src/domain/entities/bill_total.dart';
import 'package:administration/src/domain/utils/calculate_bill_total.dart';
import 'package:administration/src/infra/data_sources/administration_data_source.dart';
import 'package:core/core.dart';

import 'package:drift/drift.dart';
import 'package:internal_database/internal_database.dart';

import '../../domain/errors/administration_errors.dart';

class AdministrationDataSourceInternalImpl implements AdministrationDataSource {
  final AppDatabase _internalDatabase;

  AdministrationDataSourceInternalImpl(this._internalDatabase);

  // Bills

  Future<Request> createBill(NewBill bill, NewRequest request) async {
    try {
      final bi = await _internalDatabase
          .into(_internalDatabase.bill)
          .insertReturning(BillAdapter.createBill(bill));

      return await createRequest(request, bi.id);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-createBill",
        e,
        e.toString(),
      );
    }
  }

  // Handle bill Insertion (create or update bill)

  Future<BillData?> checkBillExist(NewBill newBill) async {
    try {
      return (_internalDatabase.select(_internalDatabase.bill)
            ..where(
              (tbl) =>
                  tbl.status.isIn([
                    BillStatus.open.index,
                    BillStatus.closed.index,
                    BillStatus.partiallyPaid.index,
                  ]) &
                  (tbl.table.equals(newBill.table!) |
                      tbl.customerName.equals(
                        newBill.customerName!,
                      )), // TODO somehow request one to be required
            ))
          .getSingleOrNull();
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-checkBillExist",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<Request> handleBillCreationOrUpdate(
    NewBill newBill,
    NewRequest newRequest,
  ) async {
    try {
      final bill = await checkBillExist(newBill);
      if (bill != null) {
        return createBill(newBill, newRequest);
      } else {
        return createRequest(newRequest, bill!.id);
      }
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-handleBillCreationOrUpdate",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> cancelBill(String id) {
    try {
      final txID = (_internalDatabase.update(_internalDatabase.bill)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        const BillCompanion(status: Value(BillStatus.canceled)),
      );
      // Cancel requests and items

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

  Future<BillTotal> getBillTotalWithPaidAmount(String billID) async {
    try {
      final billTotal = await getBillTotal(billID);
      final amountPaid = await getTotalBillPayments(billID);

      billTotal.payment = amountPaid;

      return billTotal;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBillTotalWithPaidAmount",
        e,
        e.toString(),
      );
    }
  }

  Future<int> updateBillStatus(String billID, BillStatus status) async {
    try {
      final txID = await (_internalDatabase.update(_internalDatabase.bill)
            ..where((tbl) => tbl.id.equals(billID)))
          .write(BillCompanion(status: Value(status)));

      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-updateBillStatus",
        e,
        e.toString(),
      );
    }
  }

// TODO COmplete Solution
  @override
  Future<int> finalizeBill(List<Payment> payments, String billID) async {
    try {
      final billTotal = await getBillTotalWithPaidAmount(billID);

      await _internalDatabase.batch(
        (batch) => batch.insertAll(
          _internalDatabase.item,
          payments.map((e) => PaymentAdapter.createPayment(e, billID)),
        ),
      );

      final totalPayment = payments.fold(
        0.0,
        (previousValue, element) => previousValue + element.value,
      );

      final total = billTotal.total - billTotal.payment!;
      final subtotal = billTotal.subtotal - billTotal.payment!;

      if (totalPayment >= total) {
        return updateBillStatus(billID, BillStatus.paid);
      } else if (totalPayment >= subtotal) {
        return updateBillStatus(billID, BillStatus.paidWithoutCommission);
      } else {
        return updateBillStatus(billID, BillStatus.partiallyPaid);
      }
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-finalizeBill",
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

  // TODO Calculate real total
  Future<BillTotal> calculateBillTotal(double subtotal, String billID) async {
    final bill = await (_internalDatabase.select(_internalDatabase.bill).join([
      leftOuterJoin(
        _internalDatabase.billType,
        _internalDatabase.billType.id.equalsExp(_internalDatabase.bill.id),
      )
    ])
          ..where(_internalDatabase.bill.id.equals(billID)))
        .getSingle();

    final billType = bill.readTable(_internalDatabase.billType);

    return calculateTotal(subtotal, billType.type, billType.value);
  }

  // TODO Get total, subtotal, comission
  @override
  Future<BillTotal> getBillTotal(String billID) async {
    try {
      final items = (_internalDatabase.select(_internalDatabase.request).join([
        leftOuterJoin(
          _internalDatabase.item,
          _internalDatabase.item.requestId
              .equalsExp(_internalDatabase.request.id),
        )
      ])
            ..where(
              _internalDatabase.request.billId.equals(billID) &
                  _internalDatabase.item.status.isIn(
                      [ItemStatus.preparing.index, ItemStatus.delivered.index]),
            ))
          .get();

      final subtotal = await items
          .then(
            (value) =>
                value.map((e) => e.readTable(_internalDatabase.item)).toList(),
          )
          .then((value) => value.fold(
              0.0,
              (previousValue, element) =>
                  previousValue + (element.price * element.quantity)));

      return calculateBillTotal(subtotal, billID);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBillTotal",
        e,
        e.toString(),
      );
    }
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

  // Items
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
        "InternalDatabase-Administration-createItem",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<Item>> getBillValidItems(String billID) async {
    try {
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

      final items =
          _query.map((e) => e.readTable(_internalDatabase.item)).toList();

      return items.map(ItemAdapter.toItem).toList();
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBillValidItems",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> changeItemStatus(String id, ItemStatus status) {
    try {
      final txID = (_internalDatabase.update(_internalDatabase.item)
            ..where((tbl) => tbl.id.equals(id)))
          .write(ItemCompanion(status: Value(status)));

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

  Future<int> changeAllItemsStatus(String requestID, ItemStatus status) {
    try {
      final txID = (_internalDatabase.update(_internalDatabase.item)
            ..where((tbl) => tbl.requestId.equals(requestID)))
          .write(ItemCompanion(status: Value(status)));

      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-setAllItemsDelivered",
        e,
        e.toString(),
      );
    }
  }

  //Requests

  @override
  Future<int> changeRequestStatus(
    String requestID,
    RequestStatus status,
    ItemStatus itemStatus,
  ) async {
    try {
      final txID = await (_internalDatabase.update(_internalDatabase.request)
            ..where((tbl) => tbl.id.equals(requestID)))
          .write(
        RequestCompanion(status: Value(status)),
      );
      final _ = await changeAllItemsStatus(requestID, itemStatus);
      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-setRequestDelivered",
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

      // Change to batch (return items currently not supported by drift)
      final items = await Future.wait(
        request.items.map((e) => createItem(e, req.id)).toList(),
      );

      return RequestAdapter.fromRequestDataWithItems(req, items);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-createRequest",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<Request>> getLastRequests() async {
    try {
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
                      ]) &
                      _internalDatabase.request.status
                          .isNotIn([RequestStatus.canceled.index]),
                ))
              .get();

      final requests =
          _query.map((e) => e.readTable(_internalDatabase.request)).toList();
      final items =
          _query.map((e) => e.readTable(_internalDatabase.item)).toList();

      return RequestAdapter.groupRequesWithItems(requests, items);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getLastRequests",
        e,
        e.toString(),
      );
    }
  }

  // TODO
  @override
  Future<List<Request>> getBillValidRequests(String billID) async {
    try {
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

      return RequestAdapter.groupRequesWithItems(requests, items);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBillValidRequests",
        e,
        e.toString(),
      );
    }
  }

  // Products

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
}
