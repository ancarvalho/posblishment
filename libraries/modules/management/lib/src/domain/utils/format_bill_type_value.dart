import 'package:core/core.dart';
import 'package:design_system/design_system.dart';

String formatBillTypeValue(BillTypes type, double value) {
  switch (type) {
    case BillTypes.percentageTax:
      return "${value.toInt()}%";
    case BillTypes.fixedTax:
      return CurrencyInputFormatter.formatRealCurrency(value);
    case BillTypes.withoutTax:
      return "";
  }
}
