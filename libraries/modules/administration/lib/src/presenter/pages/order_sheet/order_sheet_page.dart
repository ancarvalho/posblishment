import 'package:administration/src/presenter/widgets/order_sheet/order_sheet_store.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/order_sheet/order_sheet_widget.dart';

// Remember this could only be used with products using code
class OrderSheetPage extends StatefulWidget {
  const OrderSheetPage({super.key});

  @override
  State<OrderSheetPage> createState() => _OrderSheetPageState();
}

class _OrderSheetPageState extends State<OrderSheetPage> {
  final OrderSheetStore _orderSheetStore = Modular.get<OrderSheetStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Comanda Virtual"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _orderSheetStore.clearRequest,
              icon: const Icon(Icons.clear),
            )
          ],
        ),
        body: const OrderSheetWidget(),
      ),
    );
  }
}
