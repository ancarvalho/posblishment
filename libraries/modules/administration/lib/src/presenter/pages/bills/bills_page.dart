import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/bills/bills_widget.dart';
import '../../widgets/order_sheet/order_sheet_store.dart';
import '../../widgets/order_sheet/order_sheet_widget.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Contas"),
          centerTitle: true,
          actions: [
            if (!Sizes.isMobile(context))
              IconButton(
                onPressed: () {
                  Modular.get<OrderSheetStore>().clearRequest();
                },
                icon: const Icon(Icons.clear),
              )
          ],
        ),
        //TODO insert a Grid builder based on width minimum of 200px
        body: Sizes.isMobile(context)
            ? const BillsWidget()
            : Row(
                children: const [
                  Expanded(flex: 2, child: OrderSheetWidget()),
                  Expanded(flex: 2, child: BillsWidget()),
                ],
              ),
      ),
    );
  }
}
