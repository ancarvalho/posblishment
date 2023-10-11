import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/product/product_widget.dart';
import '../../widgets/products/products.dart';
import '../../widgets/search/search_widget.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final index = ValueNotifier<int?>(null);

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
                    Modular.to.pushNamed(
                      "${PagesRoutes.product.dependsOnModule.route}${PagesRoutes.product.route}",
                      // arguments: Product.empty(),
                    );
                  },
                ),
            ],
          ),
          body: Sizes.isMobile(context)
              ? const ProductsWidget()
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ProductsWidget(
                        setIndex: (i) {
                          index.value = i;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: ProductWidget(
                          // key: UniqueKey(), // issue with keyboard
                          index: index.value,
                        ),)
                  ],
                ),),
    );
  }
}
