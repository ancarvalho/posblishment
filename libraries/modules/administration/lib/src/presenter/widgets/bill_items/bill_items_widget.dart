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
        onLoading:(context) =>  const LoadingWidget(),
        onError: (context, error) =>
            AdministrationErrorWidget(error: error, reload: reload),
        onState: (context, items) {
          return Column(
            children: [
              
              Flexible(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    
                    return BillItemWidget(item: items[index]);
                  },
                ),
              ),
              BillTotalWidget(
                billID: widget.billID,
              )
            ],
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
