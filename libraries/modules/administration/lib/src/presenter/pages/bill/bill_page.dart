import 'package:administration/src/presenter/widgets/bill_items/bill_items_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/bill_card/bill_card_controller.dart';
import '../../widgets/bill_requests/bill_requests_widget.dart';
import '../../widgets/dialog/bill_dialog.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key, required this.bill});
  final Bill bill;

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

   final billCardController = BillCardController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mesa ${widget.bill.table}"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => CustomBillDialog(
                        bill: widget.bill,
                        closeBill: () =>
                            billCardController.closeBill(widget.bill.id),
                        cancelBill: () =>
                            billCardController.cancelBill(widget.bill.id),
                        paymentBill: () => Modular.to.pushNamed(
                          "${PagesRoutes.payment.dependsOnModule.route}${PagesRoutes.payment.route}",
                          arguments: widget.bill.id,
                        ),
                      ),
                    ),
                icon: const Icon(Icons.more_vert_rounded))
          ],
          bottom: Sizes.isMobile(context)
              ? TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.list_alt_outlined),
                    ),
                    Tab(icon: Icon(Icons.line_style_sharp)),
                  ],
                )
              : null,
        ),
        body: Sizes.isMobile(context)
            ? TabBarView(
                // TODO fix the scroll controller https://stackoverflow.com/questions/53826661/flutter-tabcontroller-index-does-not-respond-to-changes-in-the-tabbarview
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  BillItemsWidget(billID: widget.bill.id),
                  BillRequestsWidget(bill: widget.bill)
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: BillItemsWidget(billID: widget.bill.id),
                  ),
                  Expanded(
                    flex: 2,
                    child: BillRequestsWidget(bill: widget.bill),
                  )
                ],
              ),
      ),
    );
  }
}
