import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import "package:flutter_modular/flutter_modular.dart";
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/use_cases.dart';
import 'bill_types_store.dart';

class ChangeBillTypeDialog extends StatelessWidget {
  // TODO change for suit better another models

  final Bill bill;

  const ChangeBillTypeDialog(
      {Key? key, required this.bill,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updateTypeOfBill = Modular.get<IUpdateTypeOfBill>();
    final billTypesStore = Modular.get<BillTypesStore>();

    final newBillTypeId = ValueNotifier<String?>(bill.billTypeId);
    billTypesStore.getBillTypes();
    return SimpleDialog(
      title: Text("Mudar Tipo de Conta ${bill.table}"),
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
              ScopedBuilder<BillTypesStore, Failure, List<BillType>>(
                store: billTypesStore,
                onState: (context, state) {
                  return SizedBox(
                    width: 130,
                    child: CustomDropDown(
                      items: <String, String>{
                        for (final status in state)
                          status.id: status.name
                      },
                      value: newBillTypeId.value,
                      setValue: (value) => newBillTypeId.value = value,
                      labelText: "tipo de conta ",
                    ),
                  );
                },
                
              ),
              TextButton(
                onPressed: () {
                  if (newBillTypeId.value != null) {
                    updateTypeOfBill.call(bill.id, newBillTypeId.value!);
                  }
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
