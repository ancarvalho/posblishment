import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'change_bill_type.dart';

class CustomBillDialog extends StatelessWidget {
  // TODO change for suit better another models
  final Bill bill;
  final Function closeBill;
  final Function cancelAllBill;
  final Function paymentBill;

  const CustomBillDialog({
    Key? key,
    required this.closeBill,
    required this.cancelAllBill,
    required this.paymentBill,
    required this.bill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Acoes da Mesa ${bill.table}"),
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: Paddings.paddingLTRB4(),
          child: Column(
            children: [
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  closeBill();
                  Navigator.pop(context);
                },
                child: const Text('Fechar Conta'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => ChangeBillTypeDialog(bill: bill),
                  );
                },
                child: const Text('Mudar Tipo de Conta'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  cancelAllBill();
                  Navigator.pop(context);
                },
                child: const Text('Cancelar Conta'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  paymentBill();
                },
                child: const Text('Pagamento'),
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
