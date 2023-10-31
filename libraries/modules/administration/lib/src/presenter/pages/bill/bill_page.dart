import 'package:administration/src/presenter/widgets/bill_items/bill_items_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../widgets/bill_requests/bill_requests_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Mesa ${widget.bill.table}"),
          centerTitle: true,
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
                  BillRequestsWidget(billID: widget.bill.id)
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
                    child: BillRequestsWidget(billID: widget.bill.id),
                  )
                ],
              ),
      ),
    );
  }
}
