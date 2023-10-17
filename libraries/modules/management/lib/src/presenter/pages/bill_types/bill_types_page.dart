import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../widgets/bill_type/bill_type_store.dart';
import '../../widgets/bill_type/bill_type_widget.dart';
import '../../widgets/bill_types/bill_types_widget.dart';

class BillTypesPage extends StatefulWidget {
  const BillTypesPage({super.key});

  @override
  State<BillTypesPage> createState() => _BillTypesPageState();
}

class _BillTypesPageState extends State<BillTypesPage> {
  final index = ValueNotifier<int?>(null);
  final billTypeStore = Modular.get<BillTypeStore>();

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
                  Modular.to.pushNamed(
                    "${PagesRoutes.billType.dependsOnModule.route}${PagesRoutes.billType.route}",
                  );
                },
                icon: const Icon(Icons.add),
              )
            else
              IconButton(
                onPressed: billTypeStore.clearFields,
                icon: const Icon(Icons.clear),
              ),
          ],
        ),
        //TODO insert a Grid builder based on width minimum of 200px
        body: Sizes.isMobile(context)
            ? const BillTypesWidget()
            : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: BillTypesWidget(
                      setIndex: (i) {
                        index.value = i;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: BillTypeWidget(
                      index: index.value,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
