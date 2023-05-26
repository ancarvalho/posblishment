import 'package:core/core.dart';
import 'package:d_chart/d_chart.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/enums/frequency.dart';
import '../error/error_widget.dart';
import 'most_sold_products_store.dart';

class MostSoldProductsPage extends StatefulWidget {
  const MostSoldProductsPage({super.key});

  @override
  State<MostSoldProductsPage> createState() => _MostSoldProductsPageState();
}

class _MostSoldProductsPageState extends State<MostSoldProductsPage> {
  final store = Modular.get<MostSoldProductsStore>();
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
              "Mais Vendidos",
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
                        padding: const EdgeInsets.symmetric(horizontal: 2),
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
        ScopedBuilder<MostSoldProductsStore, Failure,
            List<ItemsSold>>.transition(
          store: store,
          onError: (context, error) => DashboardErrorWidget(
            error: error,
            reload: () {
              reload(_frequency);
            },
          ),
          onLoading: (context) => const CircularProgressIndicator(),
          onState: (context, state) => Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DChartBar(
                  data: [
                    {
                      'id': 'Bar',
                      'data': [
                        ...state
                            .map(
                              (e) => {
                                "domain": e.name,
                                "measure": e.totalQuantity
                              },
                            )
                            .toList()
                      ],
                    },
                  ],
                  yAxisTitle: 'Quantidade',
                  xAxisTitle: 'Produtos',
                  measureMin: 0,
                  measureMax: 31,
                  minimumPaddingBetweenLabel: 1,
                  domainLabelPaddingToAxisLine: 16,
                  axisLineTick: 2,
                  axisLinePointTick: 2,
                  axisLinePointWidth: 10,
                  axisLineColor: Theme.of(context).colorScheme.secondary,
                  //TODO Modify color to a visible on theme
                  domainLabelColor: Theme.of(context).textTheme.headlineSmall?.color,
                  measureLabelColor: Theme.of(context).textTheme.headlineSmall?.color,
                  measureAxisTitleColor: Theme.of(context).colorScheme.secondary,
                  domainAxisTitleColor: Theme.of(context).colorScheme.secondary,
                  measureLabelPaddingToAxisLine: 16,
                  verticalDirection: false,
                  domainLabelRotation: 0,
                  barColor: (barData, index, id) => barData['measure'] >= 4
                      ? Colors.green.shade300
                      : Colors.green.shade700,
                  barValue: (barData, index) => '${barData['measure']}',
                  showBarValue: true,
                  barValuePosition: BarValuePosition.inside,
                  showDomainLine: false,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
