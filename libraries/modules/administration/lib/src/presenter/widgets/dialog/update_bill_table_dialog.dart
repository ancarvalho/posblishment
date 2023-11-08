import 'package:administration/src/domain/use_cases/use_cases.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_modular/flutter_modular.dart";

import '../bills/bills_store.dart';

class UpdateBillTableDialog extends StatelessWidget {
  // TODO change for suit better another models

  final String billId;
  final int? table;

  UpdateBillTableDialog({
    Key? key,
    required this.billId,
    this.table,
  }) : super(key: key) {
    updateBillTable = Modular.get<IUpdateBillTable>();
    controller = TextEditingController();
  }

  late final IUpdateBillTable updateBillTable;
  late final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Transferir Mesa $table"),
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
              SizedBox(
                width: 42,
                child: CustomTextFormField(
                  decorationName: "Mesa",
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              SizedBox(
                height: Sizes.dp6(context),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text != "" &&
                      int.tryParse(controller.text) != null) {
                    updateBillTable.call(
                      billId,
                      int.tryParse(controller.text)!,
                    );
                    Modular.get<NotPaidBillsStore>().getNotPaidBills();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Transferir'),
              ),
              SizedBox(
                height: Sizes.dp6(context),
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
