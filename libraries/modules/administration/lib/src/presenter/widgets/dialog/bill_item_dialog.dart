import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_modular/flutter_modular.dart";

import '../../../domain/use_cases/cancel_bill_item.dart';

class CustomBillItemDialog extends StatelessWidget {
  // TODO change for suit better another models

  final Item item;
  final String billId;
  final int? quantity;

  const CustomBillItemDialog(
      {Key? key, required this.item, required this.billId, this.quantity,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cancelBillItems = Modular.get<ICancelBillItem>();
    final controller = TextEditingController(
        text: quantity != null ? quantity.toString() : "1",);
    return SimpleDialog(
      title: Text("Cancelar ${item.name}"),
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
                    decorationName: "Qnt",
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],),
              ),
              TextButton(
                onPressed: () {
                  cancelBillItems.call(billId, item.productId, int.tryParse(controller.text) ?? 1);
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
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
