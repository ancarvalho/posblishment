import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/error/error_widget.dart';
import '../../widgets/product_card/product_card_widget.dart';

import 'products_list_store.dart';

class ProductsWidget extends StatefulWidget {
  final Function(int index)? setIndex;
  const ProductsWidget({super.key,  this.setIndex});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
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
    return RefreshIndicator(
      onRefresh: reload,
      child: ScopedBuilder<ProductListStore, Failure, List<Product>>(
        store: store,
        onLoading: (context) => const LoadingWidget(),
        onError: (context, error) => ManagementErrorWidget(
          error: error,
          reload: reload,
        ),
        onState: (context, state) {
          return Padding(
            padding: Paddings.paddingLTRB4(),
            child: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                //TODO Analyze way to remove this container
                return ProductCardWidget(
                  product: state[index],
                  setIndex: () => widget.setIndex!(index),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
