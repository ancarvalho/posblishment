import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posblishment/app/app_module.dart';
import 'package:posblishment/app/app_widget.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const App(),
    ),
  );
}
