import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/presenter/widgets/bill_type_card/bill_type_card_widget.dart';
import 'package:management/src/presenter/widgets/error/error_widget.dart';

import 'bill_types_store.dart';

class BillTypesWidget extends StatefulWidget {
  // final Function(int index)? setIndex;
  const BillTypesWidget({super.key});

  @override
  State<BillTypesWidget> createState() => _BillTypesWidgetState();
}

class _BillTypesWidgetState extends State<BillTypesWidget> {
  final billTypesStore = Modular.get<BillTypesStore>();

  Future<void> loadData() async {
    await billTypesStore.getBillTypes();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<BillTypesStore, Failure, List<BillType>>(
      store: billTypesStore,
      onError: (context, error) => ManagementErrorWidget(
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
                return BillTypeCardWidget(
                  // setIndex: (index) {
                  //   billTypeStore.resetFields(billTypesStore.state[index]);
                  //   widget.setIndex!(index);
                  // },
                  index: index,
                  billType: state[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
