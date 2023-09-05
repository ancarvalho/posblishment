import 'package:administration/src/presenter/widgets/bill_items/bill_items_store.dart';
import 'package:administration/src/presenter/widgets/error/error_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../bill_item/bill_item_widget.dart';
import '../bill_total/bill_total_widget.dart';

class BillItemsWidget extends StatefulWidget {
  final String billID;
  const BillItemsWidget({super.key, required this.billID});

  @override
  State<BillItemsWidget> createState() => BillItemsWidgetState();
}

class BillItemsWidgetState extends State<BillItemsWidget> {
  final billItemsStore = Modular.get<BillItemsStore>();

  late Disposer _billItemsObserverDisposer;
  @override
  void initState() {
    _billItemsObserverDisposer = billItemsStore.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, error.errorMessage);
      },
    );

    reload();
    super.initState();
  }

  void reload() {
    billItemsStore.getBillItems(widget.billID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<BillItemsStore, Failure, List<Item>>(
        store: billItemsStore,
        onLoading: (context) => const LoadingWidget(),
        onError: (context, error) =>
            AdministrationErrorWidget(error: error, reload: reload),
        onState: (context, items) {
          return LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: SizedBox(
                    width: Sizes.width(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Table(
                              border: TableBorder(
                                bottom: BorderSide(
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(30),
                                1: FlexColumnWidth(),
                                2: FixedColumnWidth(30),
                                3: IntrinsicColumnWidth(),
                                4: FixedColumnWidth(50),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: <TableRow>[
                                const TableRow(
                                  children: <Widget>[
                                    Text("Cd", style: TextStyle(fontSize: 16)),
                                    Text(
                                      "Nome",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text("Qt", style: TextStyle(fontSize: 16)),
                                    Text(
                                      "Preço",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text("", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                ...items.map(
                                  (e) => billItemWidget(
                                    billId: widget.billID,
                                    context: context,
                                    item: e,
                                  ),
                                ),
                                const TableRow(
                                  children: [
                                    Text(""),
                                    Text(""),
                                    Text(""),
                                    Text(""),
                                    Text("")
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BillTotalWidget(
                              billID: widget.billID,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },

      ),
    );
  }

  @override
  void dispose() {
    _billItemsObserverDisposer();
    super.dispose();
  }
}
