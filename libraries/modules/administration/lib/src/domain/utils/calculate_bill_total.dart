import 'package:core/core.dart';

BillTotal calculateTotal(double subtotal, BillTypes billType, double? value) {
  switch (billType) {
    case BillTypes.deliveryTax:
      return calculateDeliveryTax(subtotal, value!);
    case BillTypes.percentageTax:
      return calculatePercentageTax(subtotal, value!);
    case BillTypes.withoutTax:
      return formatToBillTotal(subtotal, 0);
  }
}

BillTotal calculateDeliveryTax(double subtotal, double value) {
  return formatToBillTotal(subtotal, value);
}

BillTotal calculatePercentageTax(double subtotal, double value) {
  final percentage = value / 100;

  return formatToBillTotal(subtotal, percentage * subtotal);
}

BillTotal formatToBillTotal(double subtotal, double commission) {
  return BillTotal(
    total: subtotal + commission,
    subtotal: subtotal,
    commission: commission,
  );
}
