import 'dart:math';

import 'package:administration/src/presenter/widgets/bill_total/bill_total_store.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import "package:flutter_triple/flutter_triple.dart";
import '../../../domain/entities/bill_total.dart';
import '../../../domain/errors/administration_error_widgetd.dart';

class BillTotalWidget extends StatefulWidget {
  final String billID;
  const BillTotalWidget({super.key, required this.billID});

  @override
  State<BillTotalWidget> createState() => _BillTotalWidgetState();
}

class _BillTotalWidgetState extends State<BillTotalWidget> {
  final BillTotalStore _billTotalStore = Modular.get<BillTotalStore>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    _billTotalStore.getBillTotal(widget.billID);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<BillTotalStore, Failure, BillTotal>(
      store: _billTotalStore,
      onError: (context, error) => AdministrationErrorWidget(
        error: error,
        reload: loadData,
      ),
      onLoading: (context) => const LoadingWidget(),
      onState: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "subtotal",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  state.subtotal.toString(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  state.total.toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
