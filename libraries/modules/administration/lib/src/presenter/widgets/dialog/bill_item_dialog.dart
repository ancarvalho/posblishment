import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_modular/flutter_modular.dart";

import '../../../domain/use_cases/cancel_bill_item.dart';
import '../bill_items/bill_items_store.dart';

class CustomBillItemDialog extends StatelessWidget {
  // TODO change for suit better another models

  final Item item;
  final String billId;
  final int? quantity;

  CustomBillItemDialog({
    Key? key,
    required this.item,
    required this.billId,
    this.quantity,
  }) : super(key: key) {
    cancelBillItems = Modular.get<ICancelBillItem>();
    controller = TextEditingController(
      text: quantity != null ? quantity.toString() : "1",
    );
  }

  late final ICancelBillItem cancelBillItems;
  late final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              SizedBox(
                height: Sizes.dp6(context),
              ),
              TextButton(
                onPressed: () {
                  cancelBillItems.call(billId, item.productId,
                      int.tryParse(controller.text) ?? 1);
                  Modular.get<BillItemsStore>().getBillItems(billId);
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
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
