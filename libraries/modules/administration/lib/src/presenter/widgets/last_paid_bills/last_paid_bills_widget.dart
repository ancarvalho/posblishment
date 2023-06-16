import 'package:administration/src/presenter/widgets/last_paid_bills/last_paid_bills_store.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class LastPaidBillWidget extends StatelessWidget {
  const LastPaidBillWidget({super.key, required this.bill});
  final Bill bill;
  // TODO Total Paid and total

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(bill.id),
            if (bill.table != null) Text(bill.table.toString()),
            if (bill.customerName != null) Text(bill.customerName!),
          ],
        ),
        Row(
          children: [
            const Text("Total Paid"),
            const Text("Total Bill"),
            Text(bill.status.name),
          ],
        )
      ],
    );
  }
}

class LastPaidBillsPage extends StatefulWidget {
  const LastPaidBillsPage({super.key});

  @override
  State<LastPaidBillsPage> createState() => _LastPaidBillsPageState();
}

class _LastPaidBillsPageState extends State<LastPaidBillsPage> {
  final lastPaidBillsStore = Modular.get<LastPaidBillsStore>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    lastPaidBillsStore.getLastPaidBills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Últimas Contas Pagas"),
        centerTitle: true,
      ),
      body: ScopedBuilder<LastPaidBillsStore, Failure, List<Bill>>(
        store: lastPaidBillsStore,
        onState: (context, bills) {
          return ListView.builder(
            itemCount: bills.length,
            itemBuilder: (context, index) {
              return LastPaidBillWidget(
                bill: bills[index],
              );
            },
          );
        },
      ),
    );
  }
}
