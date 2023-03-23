import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import "package:flutter_modular/flutter_modular.dart";
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/enums/frequency.dart';
import '../../../domain/errors/dashboard_failures.dart';
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
  Frequency _frequency = Frequency.today;

  Future<void> reload(Frequency frequency) async {
    await store.load(frequency);
  }

  @override
  void initState() {
    super.initState();
    reload(_frequency);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Faturamento",
              style: TextStyle(
                fontSize: Sizes.dp27(context),
                fontWeight: FontWeight.w700,
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
                          onPressed: () {
                            setState(() {
                              _frequency = e;
                            });
                          },
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
          onError: (context, error) {
            if (error is NoDataFound) {
              return const Center(child: Text('No Data'));
            }
            if (error is DashboardNoInternetConnection) {
              return Center(
                child: NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () {
                    store.load(_frequency);
                  },
                ),
              );
            }
            return CustomErrorWidget(message: error?.errorMessage);
          },
          onLoading: (context) => const CircularProgressIndicator(),
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
                          commission: state.commission!,
                          subtotal: state.subtotal!,
                          total: state.total!,
                        );
                      },
                    );
                  },
                  child: InvoicingWidget(
                    text: "Faturado",
                    value: state.total!,
                  ),
                ),
                InvoicingWidget(
                  text: "A Faturar",
                  value: state.notPaid!,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
