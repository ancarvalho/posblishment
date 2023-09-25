import 'package:flutter/material.dart';

void displayMessageOnSnackbar(BuildContext context, String message, {int duration = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ),
  );
}
