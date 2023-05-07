import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/errors/management_failures.dart';
// import 'package:internal_database/internal_database.dart';

import '../../widgets/error/error_widget.dart';
import '../../widgets/item/item_widget.dart';
import 'products_list_store.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final store = Modular.get<ProductListStore>();
  // final controller = Modular.get<ProductsListController>();

  Future<void> reload() async {
    await store.list();
  }

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Produtos"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search For Product',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Create New Product',
              onPressed: () {
                Modular.to.pushNamed(
                  './product',
                  arguments: Product.empty(),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
          child: RefreshIndicator(
            onRefresh: reload,
            child: ScopedBuilder<ProductListStore, Failure, List<Product>>(
              store: store,
              onLoading: (context) => const LoadingWidget(),
              onError: (context, error) => ManagementErrorWidget(
                  error: error,
                  reload: reload,
                )
              ,
              onState: (context, state) {
                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    //TODO Analyze way to remove this container
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: Sizes.dp4(context)),
                      height: Sizes.height(context) / 10,
                      child: ItemWidget(
                        product: state[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
