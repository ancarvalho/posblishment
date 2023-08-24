
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/basic_statistics/basic_statistics_page.dart';
import '../../widgets/most_sold_products/most_sold_products_page.dart';
import '../../widgets/most_sold_products/most_sold_products_store.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final store = Modular.get<MostSoldProductsStore>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(title: const Text("Estatísticas"), centerTitle: true,),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Sizes.width(context)*.02),
            child: Column(
              children:  [
                SizedBox(height: Sizes.heightPercentile125(context),),
                const BasicStatisticsPage(),
                SizedBox(height: Sizes.heightPercentile125(context),),
                const MostSoldProductsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
