import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posblishment/app/settings/presenter/pages/printer/printer_controller.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({super.key});

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  final printerController = PrinterController();

  @override
  void initState() {
    printerController
      ..resetFields()
      ..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    printerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Impressora"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: Paddings.paddingForm(),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomTextFormField(
                        decorationName: "Ip da impressora",
                        controller: printerController.printerIpTextController,
                        keyboardType: TextInputType.number,
                        value: printerController.printerIpTextController.text,
                      ),
                    ),
                    Expanded(
                      // flex: 1,
                      child: CustomTextFormField(
                        decorationName: "Porta",
                        controller: printerController.printerPortTextController,
                        value: printerController.printerPortTextController.text,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Habilitar Impressora "),
                    Switch(
                      value: printerController.enablePrinter,
                      onChanged: (v) {
                        printerController.enablePrinter = v;
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: printerController.printer.printTest,
                      child: const Text("Testar Impressora"),
                    ),
                    ElevatedButton(
                      onPressed: printerController.connect,
                      child: const Text("Conectar"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: printerController.saveChanges, child: const Icon(Icons.save)),
      ),
    );
  }
}
