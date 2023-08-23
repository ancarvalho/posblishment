import 'package:administration/src/presenter/widgets/bill_items/bill_items_store.dart';
import 'package:core/core.dart';
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

  @override
  void initState() {
    billItemsStore.getBillItems(widget.billID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<BillItemsStore, Failure, List<Item>>(
      store: billItemsStore,
      onState: (context, items) {
        return Column(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return BillItemWidget(item: items[index]);
              },
            ),
            BillTotalWidget(
              billID: widget.billID,
            )
          ],
        );
      },
    );
  }
}
