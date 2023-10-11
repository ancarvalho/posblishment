import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:printer/commands.dart';
import 'package:printer/domain/entities/entities.dart';
import 'package:printer/domain/enums/enums.dart';
import 'package:printer/printer.dart';

class PrinterExtend implements PrinterAbstract {
  PrinterCommands? printer;

  @override
  void connect(String address, {int? port = 9100}) {
    printer = Printer.printerTCPConnection(address: address);
  }

  @override
  void disconnect() {
    if (printer != null) {
      printer?.disconnect();
      printer = null;
    }
  }

  @override
  void printRequestItemByCategory(
      List<RequestItemWithCategory> requestItemWithCategory, int table,) {
    final categorizedProduct = <String, List<RequestItemWithCategory>>{};
    for (final item in requestItemWithCategory) {
      if (categorizedProduct.containsKey(item.categoryName)) {
        categorizedProduct[item.categoryName]?.add(item);
        continue;
      }
      categorizedProduct[item.categoryName] = [item];
    }

    for (final c in categorizedProduct.keys) {
      if (categorizedProduct[c] != null && categorizedProduct[c]!.isNotEmpty) {
        printer
        ?..printRow([c, getDate()],printer?.defaultPrinterTextStyle.copyWith(textAlign: TextAlign.textAlignRight))
        ..printRow(["Mesa: $table"],printer?.defaultPrinterTextStyle.copyWith(textAlign: TextAlign.textAlignRight))
        ..feedPaper(70);
        for (final i in categorizedProduct[c]!) {
          printer?.printRow([i.quantity.toString(), i.productName] ,printer?.defaultPrinterTextStyle.copyWith(textSize: TextSize.textSizeBig));
        }
        printer
        ?..feedPaper(150)
        ..cutPaper();
      }
    }
    
  }

  @override
  void printBill(Bill bill, List<Item> items, BillTotal billTotal) {
    printer
      ?..printRow(
        ["Peixada"],
        printer?.defaultPrinterTextStyle
            .copyWith(textSize: TextSize.textSizeBig5),
      )
      ..printRow(
        ["do Pareia"],
        printer?.defaultPrinterTextStyle
            .copyWith(textSize: TextSize.textSizeBig4),
      )
      ..feedPaper(80) // TODO check here spacer
      ..printRow(["Barra Nova - Marechal Deodoro/Al"])
      ..feedPaper(80) // TODO check here spacer
      ..printRow(["Mesa: ${bill.table}", getDate()],printer?.defaultPrinterTextStyle.copyWith(textAlign: TextAlign.textAlignRight))
      ..feedPaper(80) ;
    printBillItem(items);
    printer?.printHR();
    printTotal(billTotal);
    printer
      ?..feedPaper(150) // TODO check here spacer
      ..printRow(["Permanência: ${calculateTimeSpent(bill.createdAt)}Min"])
      ..printRow(["Sem Valor Fiscal"])
      ..printRow(["Agradecemos a Preferência"])
      ..cutPaper();
  }

  void printBillItem(List<Item> items) {
    printer?.printTable([
      const TableItem(
        text: "Qnt.",
        columns: 1,
      ),
      const TableItem(
        text: "Nome",
        columns: 8,
      ),
      const TableItem(
        text: "Preço",
        columns: 3,
      ),
    ]);
    for (final item in items) {
      printer?.printTable([
        TableItem(
          text: item.quantity.toString(),
          columns: 1,
        ),
        TableItem(
          text: item.name,
          columns: 8,
        ),
        TableItem(
          text: CurrencyInputFormatter.formatRealCurrency(
              item.quantity * item.price,),
          columns: 3,
        ),
      ]);
    }
   
  }

  void printTotal(BillTotal billTotal) {
    printer
      ?..printRow(
          [
            "subtotal",
            CurrencyInputFormatter.formatRealCurrency(billTotal.subtotal)
          ],
          printer?.defaultPrinterTextStyle
              .copyWith(textAlign: TextAlign.textAlignRight),)
      ..printRow(
          ["", CurrencyInputFormatter.formatRealCurrency(billTotal.commission)],
          printer?.defaultPrinterTextStyle
              .copyWith(textAlign: TextAlign.textAlignRight),)
      ..printRow(
          ["TOTAL", CurrencyInputFormatter.formatRealCurrency(billTotal.total)],
          printer?.defaultPrinterTextStyle.copyWith(
              textAlign: TextAlign.textAlignRight,
              textSize: TextSize.textSizeBig,),);
  }

  int calculateTimeSpent(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    return diff.inMinutes;
  }

  String formatDate(int year, int month, int day, int hour, int minute) {
    return "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")} ${day.toString().padLeft(2, "0")}/${month.toString().padLeft(2, "0")}/$year";
  }

  String getDate() {
    final now = DateTime.now();
    return formatDate(now.year, now.month, now.day, now.hour, now.minute);
  }

  @override
  void printTest() {
    printer?.printHR();
    printer?.testPrinter();
    printer?.printHR();
  }
}
