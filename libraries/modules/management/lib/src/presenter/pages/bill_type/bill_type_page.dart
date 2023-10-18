import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/presenter/widgets/bill_type/bill_type_controller.dart';

import '../../widgets/bill_type/bill_type_widget.dart';

class BillTypePage extends StatefulWidget {
  const BillTypePage({super.key});

  @override
  State<BillTypePage> createState() => _BillTypePageState();
}

class _BillTypePageState extends State<BillTypePage> {
  final billTypeController = Modular.get<BillTypeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Navigator.of(context).canPop() ? null : const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Tipo de Conta"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: billTypeController.clearFields,
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        //TODO insert a Grid builder based on width minimum of 200px
        body: const BillTypeWidget(),
      ),
    );
  }
}
