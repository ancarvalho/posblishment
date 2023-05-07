import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/product_stock.dart';
import '../../../domain/errors/stock_failures.dart';
import '../../widgets/error/error_widget.dart';
import '../../widgets/product_stock/product_stock_widget.dart';
import 'products_stock_store.dart';

class ProductsStockPage extends StatefulWidget {
  const ProductsStockPage({super.key});

  @override
  State<ProductsStockPage> createState() => _ProductsStockPageState();
}

class _ProductsStockPageState extends State<ProductsStockPage> {
  final store = Modular.get<ProductsStockStore>();

  @override
  void initState() {
    store.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Controle Estoque"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search Product',
              onPressed: () {
                // handle the press
              },
            ),
          ],
        ),
        body: ScopedBuilder<ProductsStockStore, Failure,
            List<ProductStock>>.transition(
          store: store,
          onError: (context, error) =>
              StockControlErrorWidget(error: error, reload: store.load),
          onLoading: (context) => const LoadingWidget(),
          onState: (context, state) {
            return Padding(
              padding: EdgeInsets.all(Sizes.width(context) * .02),
              child: Column(
                children: [
                  ...state.map((e) => ProductStockWidget(productStock: e))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
