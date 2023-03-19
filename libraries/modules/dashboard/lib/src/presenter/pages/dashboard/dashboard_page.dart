import 'package:dashboard/src/presenter/widgets/most_sold_products/most_sold_products_page.dart';
import 'package:dashboard/src/presenter/widgets/most_sold_products/most_sold_products_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:design_system/design_system.dart';

import '../../widgets/basic_statistics/basic_statistics_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final store = Modular.get<MostSoldProductsStore>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
