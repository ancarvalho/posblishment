import 'package:administration/src/domain/utils/utils.dart';
import 'package:administration/src/presenter/widgets/bill_card/bill_card_controller.dart';
import 'package:administration/src/presenter/widgets/dialog/bill_dialog.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BillCardWidget extends StatelessWidget {
  final Bill bill;
  BillCardWidget({super.key, required this.bill});

  final billCardController = BillCardController();

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now().difference(bill.createdAt);
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          "${PagesRoutes.bill.dependsOnModule.route}${PagesRoutes.bill.route}",
          arguments: bill,
        );
      },
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => CustomBillDialog(
          bill: bill,
          closeBill: () => billCardController.closeBill(bill.id),
          cancelBill: () => billCardController.cancelBill(bill.id),
          paymentBill: () => Modular.to.pushNamed(
            "${PagesRoutes.payment.dependsOnModule.route}${PagesRoutes.payment.route}",
            arguments: bill.id,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: transformBillStatusIntoColor(bill.status),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                right: 5,
                child: Icon(
                  transformToIcon(bill.billType!.type),
                  color: const Color.fromARGB(255, 255, 254, 254),
                ),
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
                        fontSize: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${date.inMinutes}min",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
