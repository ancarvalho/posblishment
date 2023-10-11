import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.value,
    required this.decorationName,
    required this.controller,
    this.obscure = false,
    this.enabled = true,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
    this.errorText = "Valor Invalida",
    this.autofocus = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  final String? value;
  final String decorationName;
  final bool obscure;
  final bool enabled;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String errorText;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    if (value != null) {
      controller.text = value!;
    }

    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      obscureText: obscure,
      // decoration: InputDecoration(labelText: decorationName),
      keyboardType: keyboardType,
      focusNode: focusNode,
      validator: validator,
      enabled: enabled,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: decorationName,
        // errorText: errorText,
        errorStyle: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
        // labelStyle: const TextStyle(color: Colors.black),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 166, 24, 24)),

          // borderSide: BorderSide(color: Colors.black),
        ),
        // focusedErrorBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
        // ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        // focusedBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.black),
        // ),
      ),
      // style: Theme.of(context).colorScheme,
    );
  }
}
