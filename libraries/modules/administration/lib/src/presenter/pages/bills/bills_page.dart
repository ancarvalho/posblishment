import 'package:administration/src/presenter/widgets/bills/bills_store.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/bill_card/bill_card_widget.dart';
import '../../widgets/bills/bills_widget.dart';
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
          ),
          //TODO insert a Grid builder based on width minimum of 200px
          body: Sizes.isMobile(context)
              ? const BillsWidget()
              : Row(
                  children: const [
                    Expanded(flex: 2, child: OrderSheetWidget()),
                    Expanded(flex: 2, child: BillsWidget()),
                  ],
                ),),
    );
  }
}
