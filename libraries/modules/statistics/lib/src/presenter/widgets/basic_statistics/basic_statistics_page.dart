import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import "package:flutter_modular/flutter_modular.dart";
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/enums/frequency.dart';
import '../error/error_widget.dart';
import '../invoicing/invoicing_widget.dart';
import '../invoicing_dialog/invoicing_dialog_widget.dart';
import 'basic_statistics_store.dart';

class BasicStatisticsPage extends StatefulWidget {
  const BasicStatisticsPage({super.key});

  @override
  State<BasicStatisticsPage> createState() => _BasicStatisticsPageState();
}

class _BasicStatisticsPageState extends State<BasicStatisticsPage> {
  final store = Modular.get<BasicStatsStore>();
  final freq = ValueNotifier(Frequency.today);

  Future<void> reload() async {
    await store.load(freq.value);
  }

  void changeFreqAndReload(Frequency frequency) {
    setState(() {
      freq.value = frequency;
      Future.microtask(reload);
    });
  }

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Faturamento",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: Sizes.isMobile(context)
                        ? Sizes.dp22(context)
                        : Sizes.dp11(context),
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...Frequency.values
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(2),
                        child: CustomButton(
                          text: e.displayName,
                          isSelected: e == freq.value,
                          onPressed: () => changeFreqAndReload(e),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ],
        ),
        SizedBox(
          height: Sizes.heightPercentile125(context),
        ),
        ScopedBuilder<BasicStatsStore, Failure, BasicStatistics>.transition(
          store: store,
          onError: (context, error) => DashboardErrorWidget(
            error: error,
            reload: reload,
          ),
          onLoading: (context) => const LoadingWidget(),
          onState: (context, state) => Padding(
            padding: EdgeInsets.all(Sizes.dp9(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return InvoicingDialogWidget(
                          commission: state.commission,
                          subtotal: state.subtotal,
                          total: state.total,
                        );
                      },
                    );
                  },
                  child: InvoicingWidget(
                    text: "Faturado",
                    value: state.total,
                  ),
                ),
                InvoicingWidget(
                  text: "A Faturar",
                  value: state.notPaid,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
