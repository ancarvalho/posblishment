import 'package:administration/src/presenter/pages/bills/bills_store.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  final notPaidBillsStore = Modular.get<NotPaidBillsStore>();

  void loadData() {
    notPaidBillsStore.getNotPaidBills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contas"),
        centerTitle: true,
      ),
      //TODO insert a Grid builder based on width minimum of 200px
      body: ScopedBuilder<NotPaidBillsStore, Failure, List<Bill>>(
        onState: (context, state) {
          return Column();
        },
      ),
    );
  }
}
