import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'bills_store.dart';
import '../../widgets/bill_card/bill_card_widget.dart';

class BillsWidget extends StatefulWidget {
  const BillsWidget({super.key});

  @override
  State<BillsWidget> createState() => _BillsWidgetState();
}

class _BillsWidgetState extends State<BillsWidget> {
  final notPaidBillsStore = Modular.get<NotPaidBillsStore>();

  Future<void> loadData() async {
    await notPaidBillsStore.getNotPaidBills();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<NotPaidBillsStore, Failure, List<Bill>>(
      store: notPaidBillsStore,
      onState: (context, state) {
        return RefreshIndicator(
          onRefresh: loadData,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: .9,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: state.length,
            itemBuilder: (context, index) {
              return BillCardWidget(
                bill: state[index],
              );
            },
          ),
        );
      },
    );
  }
}
