import 'package:administration/src/presenter/widgets/dialog/update_bill_table_dialog.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bills/bills_store.dart';
import 'change_bill_type.dart';

class CustomBillDialog extends StatelessWidget {
  // TODO change for suit better another models
  final Bill bill;
  final Function closeBill;
  final Function cancelBill;
  final Function paymentBill;

  const CustomBillDialog({
    Key? key,
    required this.closeBill,
    required this.cancelBill,
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
                  Modular.get<NotPaidBillsStore>().getNotPaidBills();
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
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => UpdateBillTableDialog(
                      billId: bill.id,
                      table: bill.table,
                    ),
                  );
                },
                child: const Text('Transferir Mesa'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  cancelBill();
                  Modular.get<NotPaidBillsStore>().getNotPaidBills();
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
