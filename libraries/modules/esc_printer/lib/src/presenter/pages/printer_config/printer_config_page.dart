import 'package:design_system/design_system.dart';
import 'package:esc_printer/src/presenter/pages/printer_config/printer_config_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrinterConfigPage extends StatefulWidget {
  const PrinterConfigPage({super.key});

  @override
  State<PrinterConfigPage> createState() => _PrinterConfigPageState();
}

class _PrinterConfigPageState extends State<PrinterConfigPage> {
  final _printerConfigController = PrinterConfigController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(title: const Text("Connect to Printer"), centerTitle: true,),
        body: Padding(
          padding: Paddings.paddingForm(),
          child: Form(
            key: _printerConfigController.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Sizes.width(context)*.60,
                      child: CustomTextFormField(
                        controller: _printerConfigController.addressTextController,
                        decorationName: "URI",
                        value: _printerConfigController.addressTextController.text,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: Sizes.width(context)*.20,
                      child: CustomTextFormField(
                        controller: _printerConfigController.portTextController,
                        decorationName: "Port",
                        value: _printerConfigController.portTextController.text,
                        keyboardType: TextInputType.number,
                        // ERROR ON Editing on Start
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Sizes.width(context)*.06,
                      child: IconButton(
                        onPressed: _printerConfigController.connectToPrinter,
                        icon: const Icon(Icons.add),
                      ),
                    )
                  ],
                ),
                TextButton(onPressed: _printerConfigController.testPrinter, child: const Text("Print Test"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _printerConfigController.dispose();
    super.dispose();
  }
}
