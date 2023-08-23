import 'package:administration/src/domain/utils/utils.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';


class BillCardWidget extends StatelessWidget {
  final Bill bill;
  const BillCardWidget({super.key, required this.bill});

  // TODO Get Service Type and convert to icons and name
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now().difference(bill.createdAt);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: transformBillStatusIntoColor(bill.status)),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              right: 5,
              child: Icon(transformToIcon(bill.billType?.icon),
                  color: const Color.fromARGB(255, 255, 254, 254)),
            ),
            Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bill.billType?.name == null ? "" : bill.billType!.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    bill.table.toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${date.inMinutes}min",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w900,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
