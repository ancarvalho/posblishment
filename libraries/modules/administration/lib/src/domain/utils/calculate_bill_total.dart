import 'package:core/core.dart';

BillTotal calculateTotal(double subtotal, BillTypes billType, int? value) {
  switch (billType) {
    case BillTypes.deliveryTax:
      return calculateDeliveryTax(subtotal, value!);
    case BillTypes.percentageTax:
      return calculatePercentageTax(subtotal, value!);
    case BillTypes.withoutTax:
      return formatToBillTotal(subtotal, 0);
  }
}

BillTotal calculateDeliveryTax(double subtotal, int value) {
  return formatToBillTotal(subtotal, value as double);
}

BillTotal calculatePercentageTax(double subtotal, int value) {
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
