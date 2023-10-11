import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../dialog/bill_item_dialog.dart';

// class BillItemWidget extends StatelessWidget {
//   const BillItemWidget({
//     super.key,
//     required this.item,
//   });
//   final Item item;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Text(item.totalQuantity.toString()),
//         //TODO change to name
//         Text(item.id),
//         Text(
//           CurrencyInputFormatter.formatRealCurrency(
//               item.price * item.totalQuantity,),
//         ),
//       ],
//     );
//   }
// }

TableRow billItemWidget({
  required BuildContext context,
  required Item item,
  required String billId,
}) {
  return TableRow(
    children: <Widget>[
      Text(item.code.toString(), style: const TextStyle(fontSize: 16)),
      Text(item.name, style: const TextStyle(fontSize: 18)),
      Text("${item.quantity}", style: const TextStyle(fontSize: 16)),
      Text(
        CurrencyInputFormatter.formatRealCurrency(
          item.price * item.quantity,
        ),
        style: const TextStyle(fontSize: 16),
      ),
      Container(
        margin: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 0, 0),
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
          onTap: () {
            showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return CustomBillItemDialog(billId: billId, item: item,);
                },);
          },
          onLongPress: () {
            showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return CustomBillItemDialog(billId: billId, item: item, quantity: item.quantity,);
                },);
          },
          child: const Icon(
            Icons.remove,
            size: 18,
          ),
        ),
      ),
    ],
  );
}
