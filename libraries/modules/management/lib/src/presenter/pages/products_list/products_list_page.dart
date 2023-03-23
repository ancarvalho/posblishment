import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/entities.dart' as e;
import 'products_list_store.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final store = Modular.get<ProductListStore>();
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
                  arguments: e.Product.empty(),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Sizes.width(context)*.02),
          child: RefreshIndicator(
            onRefresh: () async {
              await reload();
            },
            child: ScopedBuilder<ProductListStore, Failure, List<e.Product>>(
              onLoading: (context) => const CircularProgressIndicator(),
              store: store,
              onState: (context, state) {
                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        Modular.to.pushNamed(
                          './product',
                          arguments: state[index],
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Sizes.dp10(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Sizes.width(context) * .06,
                              child: Text("${state[index].code ?? ""}"),
                            ),
                            SizedBox(
                              width: Sizes.width(context) * .60,
                              child: Column(
                                children: [
                                  Text(state[index].name),
                                  Text(state[index].description ?? "")
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Sizes.width(context) * .14,
                              child: Text(
                                "R\$ ${state[index].unitValue}",
                              ),
                            ),
                          ],
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
