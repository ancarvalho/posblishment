import 'package:design_system/common/utils/currency_formatter.dart';

String? validateCurrency(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe um Valor';
  }
  if (CurrencyInputFormatter.formatToDouble(value) == 0) {
    return 'Valor Invalido';
  }

  return null;
}
