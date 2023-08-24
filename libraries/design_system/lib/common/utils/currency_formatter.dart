import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


// TODO Review Code
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue,) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final  value = int.tryParse(newValue.text);


    final newText = realFormat().format(value! / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),);
  }

  static NumberFormat realFormat() =>
      NumberFormat.simpleCurrency(locale: "pt_Br", decimalDigits: 2);
  static String formatRealCurrency(double? value) => realFormat().format(value);
  static double? formatToDouble(String value) =>
      double.tryParse(value.replaceAll(RegExp('[^0-9]'), ""))!/100;
}
