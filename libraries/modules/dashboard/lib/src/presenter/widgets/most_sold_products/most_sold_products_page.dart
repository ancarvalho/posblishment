import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/enums/frequency.dart';
import '../../../domain/errors/dashboard_failures.dart';
import 'most_sold_products_store.dart';

class BasicStatisticsPage extends StatefulWidget {
  const BasicStatisticsPage({super.key});

  @override
  State<BasicStatisticsPage> createState() => _BasicStatisticsPageState();
}

class _BasicStatisticsPageState extends State<BasicStatisticsPage> {
  final store = Modular.get<MostSoldProductsStore>();
  final Frequency _frequency = Frequency.today;

  @override
  void initState() {
    super.initState();
    store.load(_frequency);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ...Frequency.values
                .map(
                  (e) => GestureDetector(
                    child: Text(e.displayName),
                    onTap: () {},
                  ),
                )
                .toList()
          ],
        ),
        ScopedBuilder<MostSoldProductsStore, Failure,
            List<ItemsSold>>.transition(
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
          onState: (context, state) => Column(),
        )
      ],
    );
  }
}
