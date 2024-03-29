import '../../core.dart';

abstract class PrinterAbstract {
  Future<void> connect(String address, {int? port = 9100});
  Future<void> checkConnection(String address, {int? port = 9100});

  Future<void> reconnect();

  Future<void> disconnect();

  // void printRequest(int table, Request request);

  void printRequestItemByCategory(
    List<RequestItemWithCategory> requestItemWithCategory,
    int table,
  );

  void printBill(Bill bill, List<Item> items, BillTotal billTotal);

  // void printBillItem(List<Item> items);

  // void printTotal(BillTotal billTotal);

  // String getDate();
  void printTest();
}
