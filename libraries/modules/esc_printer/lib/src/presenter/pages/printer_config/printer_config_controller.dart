import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrinterConfigController extends Disposable {
  PrinterConfigController();

  final PrinterAbstract? printer = Modular.get<PrinterAbstract>();
  final formKey = GlobalKey<FormState>();

  final addressTextController = TextEditingController();
  final portTextController = TextEditingController();

  void connectToPrinter() {
    if (formKey.currentState!.validate()) {
      debugPrint("connecting");
      printer?.connect(
        addressTextController.text,
        port: int.tryParse(portTextController.text),
      );
    }
  }

  void testPrinter() {
    printer?.printTest();
  }

  void clearFields() {
    addressTextController.text = "";
    portTextController.text = "";
  }

  @override
  void dispose() {
    addressTextController.dispose();
    portTextController.dispose();
  }
}
