import 'package:flutter/services.dart';

class PercentageBillTypeValue extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    int value;

    if (!newValue.text.contains("%") &&
        newValue.text.length < oldValue.text.length) {
      value =
          int.tryParse(newValue.text.substring(0, newValue.text.length - 1)) ??
              0;
    } else {
      value = int.tryParse(newValue.text.replaceFirst("%", "")) ?? 0;
    }

    final newText = "$value%";

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  static String? formatToPercentage(double? value) {
    if (value != null) {
      return "${value.toInt()}%";
    }
    return null;

  }
}
