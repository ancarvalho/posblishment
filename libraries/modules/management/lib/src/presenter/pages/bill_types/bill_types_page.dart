import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/presenter/widgets/bill_type/bill_type_controller.dart';
import '../../widgets/bill_type/bill_type_widget.dart';
import '../../widgets/bill_types/bill_types_widget.dart';

class BillTypesPage extends StatefulWidget {
  const BillTypesPage({super.key});

  @override
  State<BillTypesPage> createState() => _BillTypesPageState();
}

class _BillTypesPageState extends State<BillTypesPage> {
  // final index = ValueNotifier<int?>(null);
  final billTypeController = Modular.get<BillTypeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Tipos de Conta"),
          centerTitle: true,
          actions: [
            if (Sizes.isMobile(context))
              IconButton(
                onPressed: () {
                  billTypeController.clearFields();
                  Modular.to.pushNamed(
                    "${PagesRoutes.billType.dependsOnModule.route}${PagesRoutes.billType.route}",
                  );
                },
                icon: const Icon(Icons.add),
              )
            else
              IconButton(
                onPressed: billTypeController.clearFields,
                icon: const Icon(Icons.clear),
              ),
          ],
        ),
        //TODO insert a Grid builder based on width minimum of 200px
        body: Sizes.isMobile(context)
            ? const BillTypesWidget()
            : Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: BillTypesWidget(),
                  ),
                  Expanded(
                    flex: 3,
                    child: BillTypeWidget(
                        // index: index.value,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
