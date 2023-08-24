import 'package:administration/src/domain/utils/transform_bill_status_into_color.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BillPaidCardWidget extends StatelessWidget {
  const BillPaidCardWidget({super.key, required this.bill});
  final Bill bill;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now().difference(bill.updatedAt);
    return Card(
      color: transformBillStatusIntoColor(bill.status),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(bill.table == null
                  ? bill.table.toString()
                  : bill.customerName!,),
              Text(bill.status.name)
            ],
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("finalizada ${date.inMinutes}min atrás")],
          )
        ],
      ),
    );
  }
}
