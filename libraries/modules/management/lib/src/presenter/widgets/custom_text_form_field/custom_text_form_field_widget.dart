import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.value,
    required this.decorationName,
    required this.controller,
    this.obscure = false,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
    this.errorText = "Valor Invalida",
  }) : super(key: key);

  final String? value;
  final String decorationName;
  final bool obscure;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      controller.text = value!;
    }

    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      obscureText: obscure,
      // decoration: InputDecoration(labelText: decorationName),
      keyboardType: keyboardType,
      validator: validator,

      decoration: InputDecoration(
        labelText: decorationName,
        // errorText: errorText,
        errorStyle: const TextStyle(color: Colors.black),
        labelStyle: const TextStyle(color: Colors.black),
        errorBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).cardColor),
          // borderSide: BorderSide(color: Colors.black),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}