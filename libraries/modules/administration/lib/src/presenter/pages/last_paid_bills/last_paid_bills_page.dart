import 'package:administration/src/presenter/widgets/last_paid_bills/last_paid_bills_store.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/bill_paid_card/bill_paid_card_widget.dart';

class LastPaidBillsPage extends StatefulWidget {
  const LastPaidBillsPage({super.key});

  @override
  State<LastPaidBillsPage> createState() => _LastPaidBillsPageState();
}

class _LastPaidBillsPageState extends State<LastPaidBillsPage> {
  final _lastPaidBillsStore = Modular.get<LastPaidBillsStore>();

  Future<void> reload() async {
    await _lastPaidBillsStore.getLastPaidBills();
  }
  @override
  void initState() {
    reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Ultimas Contas"),
          centerTitle: true,
        ),
        body: ScopedBuilder<LastPaidBillsStore, Failure, List<Bill>>(
          store: _lastPaidBillsStore,
          onState: (context, state) {
            return Padding(
              padding: Paddings.paddingLTRB4(),
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return BillPaidCardWidget(bill: state[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
