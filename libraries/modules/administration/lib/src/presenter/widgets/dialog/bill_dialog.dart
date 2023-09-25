import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomBillDialog extends StatelessWidget {
  // TODO change for suit better another models
  final int? billTable;
  final Function closeBill;
  final Function cancelAllBill;
  final Function paymentBill;

  const CustomBillDialog({
    Key? key,
    required this.billTable,
    required this.closeBill,
    required this.cancelAllBill,
    required this.paymentBill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Acoes da Mesa $billTable"),
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
                  cancelAllBill();
                  Navigator.pop(context);
                },
                child: const Text('Cancelar Conta'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () => paymentBill(),
                child: const Text('Pagamento'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Sair'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
