import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import "package:flutter_modular/flutter_modular.dart";

import '../../../domain/use_cases/use_cases.dart';

class ReprintRequestDialog extends StatelessWidget {
  // TODO change for suit better another models

  final String requestID;
  final int table;

  ReprintRequestDialog({Key? key, required this.requestID, required this.table})
      : super(key: key) {
    _settingsStore = Modular.get<AbstractSettingsStore>();
    _printerExtend = Modular.get<PrinterAbstract>();
    _getRequestItemCategorized = Modular.get<IGetRequestItemCategorized>();
  }

  late final AbstractSettingsStore _settingsStore;
  late final PrinterAbstract _printerExtend;
  late final IGetRequestItemCategorized _getRequestItemCategorized;

  @override
  Widget build(BuildContext context) {
    Future<void> reprintRequest() async {
      final categorizedRequest =
          await _getRequestItemCategorized(requestID).then(
        (value) => value.fold(
          (l) {
            return null;
          },
          (r) => r,
        ),
      );
      if (categorizedRequest != null &&
          _settingsStore.state.printerSettings!.enablePrinter) {
        if (_settingsStore.state.printerSettings!.printerIp != null) {
          await _printerExtend.reconnect();
          _printerExtend

            .printRequestItemByCategory(
              categorizedRequest,
              table,
            );
        }
      }
    }

    return SimpleDialog(
      title: const Text("Reimprimir Pedido"),
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: Paddings.paddingLTRB4(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  reprintRequest();
                  Navigator.pop(context);
                },
                child: const Text('Confirmar'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Sair',
                  style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
