import 'package:administration/src/infra/data_sources/administration_data_source.dart';
import 'package:core/core.dart';

import 'package:drift/drift.dart';
import 'package:internal_database/internal_database.dart';

import '../../domain/errors/administration_errors.dart';

class AdministrationDataSourceInternalImpl implements AdministrationDataSource {
  final AppDatabase _internalDatabase;

  AdministrationDataSourceInternalImpl(this._internalDatabase);

  // Bills
  @override
  Future<Bill> createBill(NewBill newBill) async {
    try {
      final billType = newBill.billTypeID ??
          await getDefaultBillType().then((value) => value.id);
      if (billType == null) {
        throw AdministrationError(
          StackTrace.current,
          "InternalDatabase-Administration-createBill",
          "",
          "No Bill Types Defined",
        );
      }
      final bill = await _internalDatabase
          .into(_internalDatabase.bill)
          .insertReturning(BillAdapter.createBill(newBill, billType));

      // return await createRequest( bi.id);
      return BillAdapter.convertToBill(bill);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-createBill",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> cancelBill(String id) async {
    try {
      final e = await Future.wait([
        updateBillStatus(id, BillStatus.canceled),
        cancelAllBillItems(id),
        cancelBillRequests(id),
      ]);
      // final txID = await updateBillStatus(id, BillStatus.canceled);
      // // Cancel requests and items
      // await cancelBillRequests(id);
      // await cancelBillItem(id);
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

  @override
  Future<BillTotal> getBillTotalWithPaidAmount(String billID) async {
    try {
      late BillTotal billTotal;
      late double amountPaid;
      await Future.wait([
        getBillTotal(billID).then((value) => billTotal = value),
        getTotalBillPayments(billID).then((value) => amountPaid = value)
      ]);

      // final billTotal = await getBillTotal(billID);
      // final amountPaid = await getTotalBillPayments(billID);

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

  @override
  Future<int> updateBillStatus(String billID, BillStatus status) async {
    try {
      final txID = await (_internalDatabase.update(_internalDatabase.bill)
            ..where((tbl) => tbl.id.equals(billID)))
          .write(
        BillCompanion(
          status: Value(status),
          updatedAt: Value(DateTime.now()),
        ),
      );

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
  Future<int> finalizeBill(List<NewPayment> payments, String billID) async {
    try {
      final billTotal = await getBillTotalWithPaidAmount(billID);

      await _internalDatabase.batch(
        (batch) => batch.insertAll(
          _internalDatabase.payment,
          Iterable.generate(
            payments.length,
            (index) => PaymentAdapter.createPayment(payments[index], billID),
          ),
          mode: InsertMode.insertOrFail,
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
  Future<List<Bill>> getActiveBills() async {
    try {
      final billTypes = await getBillTypes();
      final bill = (_internalDatabase.select(_internalDatabase.bill)
            ..where(
              (tbl) => tbl.status.isIn([
                BillStatus.partiallyPaid.index,
                BillStatus.open.index,
                BillStatus.closed.index,
              ]),
            ))
          .map((bill) => BillAdapter.convertToBillWithType(bill, billTypes))
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
  Future<Bill> getBillByTable(int table) async {
    try {
      final bill = await (_internalDatabase.select(_internalDatabase.bill)
            ..where(
              (tbl) =>
                  tbl.table.equals(table) &
                  tbl.status.isIn(
                    [
                      BillStatus.open.index,
                      BillStatus.closed.index,
                      BillStatus.partiallyPaid.index
                    ],
                  ),
            ))

          // .map(BillAdapter.convertToBill)
          .getSingle();

      return BillAdapter.convertToBill(bill);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBillByTable",
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
        _internalDatabase.billType.id
            .equalsExp(_internalDatabase.bill.billTypeId),
      )
    ])
          ..where(_internalDatabase.bill.id.equals(billID)))
        .getSingle();

    final billType = bill.readTable(_internalDatabase.billType);

    return calculateTotal(subtotal, billType.type, billType.value);
  }

  // TODO Get total, subtotal, commission
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
                    [ItemStatus.preparing.index, ItemStatus.delivered.index],
                  ),
            ))
          .get();

      final subtotal = await items
          .then(
            (value) =>
                value.map((e) => e.readTable(_internalDatabase.item)).toList(),
          )
          .then(
            (value) => value.fold(
              0.0,
              (previousValue, element) =>
                  previousValue + (element.price * element.quantity),
            ),
          );

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
  Future<int> createItem(NewItem item, String requestID) async {
    try {
      final product = await getProduct(item.productId);
      final txId = await _internalDatabase
          .into(_internalDatabase.item)
          .insert(ItemAdapter.createItem(item, product, requestID));

      return txId;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-createItem",
        e,
        e.toString(),
      );
    }
  }

  Future<List<Item>> getBillValidItemsQuery(String billID) async {
    final q = _internalDatabase
        .customSelect(
          "SELECT i.id as id, p.code as code, p.name as name, SUM(i.quantity) as quantity, i.total_quantity as total_quantity, i.price as price, i.status as status, i.request_id as request_id, i.product_id as product_id, i.created_at as created_at, i.updated_at as updated_at "
          "FROM item i "
          "LEFT JOIN product p ON p.id = i.product_id "
          "LEFT JOIN request r ON r.id = i.request_id "
          "WHERE r.bill_id = ? AND i.status IN (0, 1) AND r.status IN (0, 1) "
          "GROUP BY i.product_id ",
          variables: [
            Variable.withString(billID),
            // Variable.withBlob(
            //   Uint8List.fromList([
            //     ItemStatus.preparing.index,
            //     ItemStatus.delivered.index,
            //   ]),
            // )
          ],
          readsFrom: {
            _internalDatabase.product,
            _internalDatabase.item,
          },
        )
        .get()
        .then((value) {
          return value
              .map(
                (row) => Item(
                  id: row.read<String>("id"),
                  code: row.read<int?>("code"),
                  name: row.read<String>("name"),
                  price: row.read<double>("price"),
                  quantity: row.read<int>("quantity"),
                  totalQuantity: row.read<int>("total_quantity"),
                  status: ItemStatus.values.elementAt(row.read<int>("status")),
                  productId: row.read<String>("product_id"),
                  requestId: row.read<String>("request_id"),
                  createdAt: row.read<DateTime>("created_at"),
                  updatedAt: row.read<DateTime?>("updated_at"),
                ),
              )
              .toList();
        });
    return q;
  }

  @override
  Future<List<Item>> getBillValidItems(String billID) async {
    try {
      return getBillValidItemsQuery(billID);
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
        "InternalDatabase-Administration-changeItemStatus",
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
        "InternalDatabase-Administration-changeAllItemsStatus",
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
        "InternalDatabase-Administration-changeRequestStatus",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<String> createRequest(String billID, NewRequest request) async {
    try {
      // Maybe wait all , need generate id for reference to items
      final req = await _internalDatabase
          .into(_internalDatabase.request)
          .insertReturning(RequestAdapter.createRequest(request, billID));

      // Change to batch (return items currently not supported by drift)
      await Future.wait(
        request.items.map((e) => createItem(e, req.id)).toList(),
      );

      return req.id;
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
      final requestItems = await _internalDatabase
          .customSelect(
            "SELECT r.id as id, p.name as name, i.quantity as quantity, r.observation as observation, r.status as status, r.created_at as created_at, r.updated_at as updated_at, r.bill_id as bill_id "
            "FROM request r "
            "LEFT JOIN item i ON i.request_id = r.id "
            "LEFT JOIN product p ON p.id = i.product_id "
            "WHERE i.status IN (0, 1) "
            "ORDER BY r.created_at DESC "
            "Limit 10",
            // variables: [
            // Variable.withBlob(
            //   Uint8List.fromList([
            //     ItemStatus.preparing.index,
            //     ItemStatus.delivered.index,
            //   ]),
            // )
            // ],
            readsFrom: {
              _internalDatabase.product,
              _internalDatabase.item,
              _internalDatabase.request
            },
          )
          .get()
          .then((value) {
            return value
                .map(
                  (row) => RequestItem(
                    id: row.read<String>("id"),
                    name: row.read<String>("name"),
                    observation: row.read<String?>("observation"),
                    quantity: row.read<int>("quantity"),
                    status: row.read<int>("status"),
                    billID: row.read<String>("bill_id"),
                    createdAt: row.read<DateTime>("created_at"),
                    updatedAt: row.read<DateTime?>("updated_at"),
                  ),
                )
                .toList();
          });

      return RequestAdapter.transformToRequest(requestItems);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getLastRequests",
        e,
        e.toString(),
      );
    }
  }

  Future<List<RequestItem>> getBillValidRequestsQuery(String billID) async {
    // TODO fix array in
    try {
      final q = _internalDatabase
          .customSelect(
            "SELECT r.id as id, p.name as name, i.quantity as quantity, r.observation as observation, r.status as status, r.created_at as created_at, r.updated_at as updated_at, r.bill_id as bill_id "
            "FROM request r "
            "LEFT JOIN item i ON i.request_id = r.id "
            "LEFT JOIN product p ON p.id = i.product_id "
            "WHERE r.bill_id = ? AND i.status IN (0, 1)",
            variables: [
              Variable.withString(billID),
              // Variable.withBlob(
              //   Uint8List.fromList([
              //     ItemStatus.preparing.index,
              //     ItemStatus.delivered.index,
              //   ]),
              // )
            ],
            readsFrom: {
              _internalDatabase.product,
              _internalDatabase.item,
              _internalDatabase.request
            },
          )
          .get()
          .then((value) {
            return value
                .map(
                  (row) => RequestItem(
                    id: row.read<String>("id"),
                    name: row.read<String>("name"),
                    observation: row.read<String?>("observation"),
                    quantity: row.read<int>("quantity"),
                    status: row.read<int>("status"),
                    billID: row.read<String>("bill_id"),
                    createdAt: row.read<DateTime>("created_at"),
                    updatedAt: row.read<DateTime?>("updated_at"),
                  ),
                )
                .toList();
          });
      return q;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBillValidRequestsQuery",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<Request>> getBillValidRequests(String billID) async {
    final requestItem = await getBillValidRequestsQuery(billID);
    return RequestAdapter.transformToRequest(requestItem);
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

  @override
  Future<BillType> getBillType(String id) async {
    try {
      final billType =
          await (_internalDatabase.select(_internalDatabase.billType)
                ..where((tbl) => tbl.id.equals(id)))
              // .map(BillTypeAdapter.convertToBillType)
              .getSingle();
      return BillTypeAdapter.convertToBillType(billType);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<BillType> getDefaultBillType() async {
    try {
      final billType =
          await (_internalDatabase.select(_internalDatabase.billType)
                ..where((tbl) => tbl.defaultType.equals(true)))
              // .map(BillTypeAdapter.convertToBillType)
              .getSingle();
      return BillTypeAdapter.convertToBillType(billType);
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getDefaultBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<BillType>> getBillTypes() {
    try {
      final billTypes = _internalDatabase
          .select(_internalDatabase.billType)
          .map(BillTypeAdapter.convertToBillType)
          .get();
      return billTypes;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getBillTypes",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> deleteBillType(String id) {
    try {
      final billTypes = (_internalDatabase.delete(_internalDatabase.billType)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
      return billTypes;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-deleteBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<bool> createBillType(NewBillType newBillType) async {
    try {
      await _internalDatabase
          .into(_internalDatabase.billType)
          .insert(BillTypeAdapter.createBillType(newBillType));
      return true;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-createBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<bool> removeBillTypeDefaultValue() async {
    try {
      await _internalDatabase
          .update(_internalDatabase.billType)
          .write(const BillTypeCompanion(defaultType: Value(false)));
      return true;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-removeDefaultValue",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<bool> setDefaultBillType(String id) async {
    try {
      await (_internalDatabase.update(_internalDatabase.billType)
            ..where((tbl) => tbl.id.equals(id)))
          .write(const BillTypeCompanion(defaultType: Value(true)));
      return true;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-setDefaultBillType",
        e,
        e.toString(),
      );
    }
  }

  List<UpdateItem> cancelItems(int quantity, List<UpdateItem> items) {
    var remainingQuantity = quantity;
    final updatedItems = <UpdateItem>[];
    for (final item in items) {
      if (remainingQuantity < 1) break;
      if (item.quantity > remainingQuantity) {
        updatedItems.add(
          UpdateItem(
            id: item.id,
            quantity: item.quantity - remainingQuantity,
            status: ItemStatus.delivered,
          ),
        );
        remainingQuantity = 0;
        continue;
      }
      updatedItems.add(
        UpdateItem(
          id: item.id,
          quantity: 0,
          status: ItemStatus.canceled,
        ),
      );
      remainingQuantity -= item.quantity;
    }

    return updatedItems;
  }

  Future<int> updateItem(UpdateItem item) async {
    return await _internalDatabase.customUpdate(
      """
      UPDATE item 
      SET quantity = ?, status = ?
      WHERE id = ?
      """,
      updates: {_internalDatabase.item},
      variables: [
        Variable.withInt(item.quantity),
        Variable.withInt(item.status!.index),
        Variable.withString(item.id),
      ],
    );
  }

  @override
  Future<void> cancelBillItemQuantity(
    String billId,
    String productId,
    int quantity,
  ) async {
    try {
      final items = await _internalDatabase
          .customSelect(
            """
        SELECT i.id as id, i.quantity as quantity
        FROM bill b
        LEFT JOIN request r ON r.bill_id = b.id
        LEFT JOIN item i ON i.request_id = r.id
        WHERE i.product_id = ? AND b.id = ? AND r.status IN (0 ,1) AND i.status IN (0, 1)
      """,
            readsFrom: {
              _internalDatabase.bill,
              _internalDatabase.request,
              _internalDatabase.item
            },
            variables: [
              Variable.withString(productId),
              Variable.withString(billId),
            ],
          )
          .get()
          .then(
            (value) => value
                .map(
                  (row) => UpdateItem(
                    id: row.read("id"),
                    quantity: row.read("quantity"),
                  ),
                )
                .toList(),
          );

      final itemsToCancel = cancelItems(quantity, items);
      for (final item in itemsToCancel) {
        await updateItem(item);
      }
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-cancelBillItemQuantity",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<bool> updateBillType(BillType newBillType) async {
    try {
      await (_internalDatabase.update(_internalDatabase.billType)
            ..where((tbl) => tbl.id.equals(newBillType.id)))
          .write(BillTypeAdapter.updateBillType(newBillType));
      return true;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-updateBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> updateTypeOfBill(String billTypeId, String billId) async {
    try {
      final txID = await _internalDatabase.customUpdate(
        """
        UPDATE bill b
        SET bill_type = ?
        WHERE id = ?
      """,
        updates: {_internalDatabase.bill},
        variables: [
          Variable.withString(billTypeId),
          Variable.withString(billId)
        ],
      );
      return txID;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-updateBillType",
        e,
        e.toString(),
      );
    }
  }

  Future<int> cancelBillRequests(String billId) async {
    final q = await _internalDatabase.customUpdate(
      """
      UPDATE request 
      SET status = ?
      WHERE bill_id = ?
      """,
      updates: {_internalDatabase.request},
      variables: [
        Variable.withInt(RequestStatus.canceled.index),
        Variable.withString(billId)
      ],
    );
    return q;
  }

  // Could Not cancel items if request is executed first
  Future<void> cancelAllBillItems(String billId) async {
    final requests = await _internalDatabase
        .customSelect(
          """
    SELECT r.id as request_id
    FROM bill b
    LEFT JOIN request r ON r.bill_id = b.id
    WHERE b.id = ? AND r.status IS NOT ?
    """,
          readsFrom: {_internalDatabase.bill, _internalDatabase.request},
          variables: [
            Variable.withString(billId),
            Variable.withInt(RequestStatus.canceled.index)
          ],
        )
        .get()
        .then(
            (value) => value.map((e) => e.read<String>("request_id")).toList());
    if (requests.isNotEmpty) await Future.wait(requests.map(cancelRequestItem));
  }

  Future<int> cancelRequestItem(String requestId) async {
    final q = await _internalDatabase.customUpdate(
      """
      UPDATE item 
      SET status = ?
      WHERE request_id = ?
      """,
      updates: {_internalDatabase.request},
      variables: [
        Variable.withInt(RequestStatus.canceled.index),
        Variable.withString(requestId)
      ],
    );
    return q;
  }

  @override
  Future<List<RequestItemWithCategory>> getRequestItemWithCategory(
      String requestId) async {
    try {
      final items = await _internalDatabase
          .customSelect(
            """
        SELECT i.quantity as quantity, p.name as product_name, c.name as category_name, c.id as category_id
        FROM request r
        LEFT JOIN item i ON i.request_id = r.id
        LEFT JOIN product p ON p.id = i.product_id
        LEFT JOIN category c ON c.id = p.category_id
        WHERE r.id = ? AND i.status IS NOT ?
        
      """,
            readsFrom: {
              _internalDatabase.request,
              _internalDatabase.product,
              _internalDatabase.category,
              _internalDatabase.item
            },
            variables: [
              Variable.withString(requestId),
              Variable.withInt(ItemStatus.canceled.index),
            ],
          )
          .get()
          .then(
            (value) => value
                .map((row) => RequestItemWithCategory(
                      productName: row.read<String>("product_name"),
                      categoryName: row.read<String>("category_name"),
                      categoryId: row.read<String>("category_id"),
                      quantity: row.read<int>("quantity"),
                    ))
                .toList(),
          );

      return items;
    } catch (e, s) {
      throw AdministrationError(
        s,
        "InternalDatabase-Administration-getRequestItemWithCategory",
        e,
        e.toString(),
      );
    }
  }
}
