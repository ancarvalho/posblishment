import 'package:administration/src/domain/utils/transform_bill_status_into_color.dart';
import 'package:administration/src/presenter/stores/bill/bill_total_store.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BillPaidCardWidget extends StatefulWidget {
  const BillPaidCardWidget({super.key, required this.bill});
  final Bill bill;

  @override
  State<BillPaidCardWidget> createState() => _BillPaidCardWidgetState();
}

class _BillPaidCardWidgetState extends State<BillPaidCardWidget> {
  final _totalBillStore = Modular.get<BillTotalStore>();

  @override
  void initState() {
    _totalBillStore.getBillTotal(widget.bill.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now()
        .difference(widget.bill.updatedAt ?? widget.bill.createdAt);
    return Card(
      color: transformBillStatusIntoColor(widget.bill.status),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bill.table != null
                      ? "Mesa ${widget.bill.table}"
                      : "${widget.bill.customerName.toString}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium,
                ),
                Text(
                  widget.bill.status.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ${CurrencyInputFormatter.formatRealCurrency(_totalBillStore.state.total)}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text("finalizada ha ${date.inMinutes} min")
              ],
            )
          ],
        ),
      ),
    );
  }
}
