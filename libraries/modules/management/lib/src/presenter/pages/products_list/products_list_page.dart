import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
// import 'package:internal_database/internal_database.dart';
import 'package:management/src/presenter/pages/products_list/products_list_controller.dart';

import '../../widgets/dialog/custom_cancel_dialog.dart';
import '../../widgets/item/item_widget.dart';
import 'products_list_store.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final store = Modular.get<ProductListStore>();
  final controller = Modular.get<ProductsListController>();

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
              onLoading: (context) => const CircularProgressIndicator(),
              store: store,
              onState: (context, state) {
                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: Sizes.dp4(context)),
                      height: Sizes.height(context) / 10,
                      child: GestureDetector(
                        onTap: () {
                          Modular.to.pushNamed(
                            './product',
                            arguments: state[index],
                          );
                        },
                        onDoubleTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomCancelDialog(
                                delete: controller.deleteProduct,
                                id: state[index].id!,
                                name: state[index].name,
                              );
                            },
                          );
                        },
                        child: ItemWidget(
                          product: state[index],
                        ),
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
