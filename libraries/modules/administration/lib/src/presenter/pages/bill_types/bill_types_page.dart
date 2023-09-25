import 'package:administration/src/presenter/pages/bill_types/bill_types_controller.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/errors/administration_error_widget.dart';
import '../../../domain/utils/utils.dart';
import '../../widgets/dialog/bill_type_dialog.dart';
import 'bill_types_store.dart';

class BillTypesPage extends StatefulWidget {
  const BillTypesPage({super.key});

  @override
  State<BillTypesPage> createState() => _BillTypesPageState();
}

class _BillTypesPageState extends State<BillTypesPage> {
  final billTypesStore = Modular.get<BillTypesStore>();
  final _billTypesController = BillTypesController();

  Future<void> loadData() async{
    await billTypesStore.getBillTypes();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Tipos de Conta"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Modular.to.pushNamed(
                    "${PagesRoutes.billType.dependsOnModule.route}${PagesRoutes.billType.route}",
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        //TODO insert a Grid builder based on width minimum of 200px
        body: ScopedBuilder<BillTypesStore, Failure, List<BillType>>(
          store: billTypesStore,
          onError: (context, error) => AdministrationErrorWidget(
            error: error,
            reload: loadData,
          ),
          onState: (context, state) {
            return RefreshIndicator(
              onRefresh: loadData,
              child: Padding(
                padding: Paddings.paddingLTRB4(),
                child: ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Modular.to.pushNamed(
                              "${PagesRoutes.billType.dependsOnModule.route}${PagesRoutes.billType.route}",
                              arguments: state[index],
                            );
                          },
                          onLongPress: () => showDialog(
                            context: context,
                            builder: (context) => CustomBillTypeDialog(
                              delete: () =>
                                  _billTypesController.deleteCurrentBillType(state[index].id),
                              setDefault: () => _billTypesController.setBillTypeAsDefault(state[index].id),
                              type: state[index].name,
                            ),
                          ),
                          child: Card(
                            child: SizedBox(
                              height: Sizes.height(context) / 10,
                              child: Padding(
                                padding: Paddings.paddingLTRB8(),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              state[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ],
                                        ),
                                        if (state[index].value != null)
                                          Text(
                                            formatBillTypeValue(
                                              state[index].type,
                                              state[index].value!,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
