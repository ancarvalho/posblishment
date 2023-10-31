import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/presenter/pages/product/product_controller.dart';

import '../../widgets/product/product_widget.dart';
import '../../widgets/products/products_widget.dart';
import '../../widgets/search/search_widget.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final productController = Modular.get<ProductController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Produtos"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchEngine());
              },
            ),
            if (Sizes.isMobile(context))
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Create New Product',
                onPressed: () {
                  productController.clearFields();
                  Modular.to.pushNamed(
                    "${PagesRoutes.product.dependsOnModule.route}${PagesRoutes.product.route}",
                    // arguments: Product.empty(),
                  );
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.clear),
                tooltip: 'Clear Fields',
                onPressed: productController.clearFields,
              ),
          ],
        ),
        body: Sizes.isMobile(context)
            ? const ProductsWidget()
            : Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: ProductsWidget(),
                  ),
                  Expanded(
                    flex: 3,
                    child: ProductWidget(),
                  )
                ],
              ),
      ),
    );
  }
}
