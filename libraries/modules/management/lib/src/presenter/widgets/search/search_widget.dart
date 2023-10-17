import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/presenter/widgets/product_card/product_card_widget.dart';
import 'package:management/src/presenter/widgets/products/products_list_store.dart';

class SearchEngine extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Pesquisar";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close),)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final productsStore = Modular.get<ProductListStore>();

    final suggestion = query.isEmpty
        ? productsStore.state
        : productsStore.state
            .where((element) =>
               [element.code, element.name, element.description].join(" ").contains(query.toLowerCase()),)
            .toList();

    return Scaffold(
        body: Padding(
      padding: Paddings.paddingLTRB4(),
      child: ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (context, index) {
          return ProductCardWidget(
            product: suggestion[index],
            index: index,
          );
        },
      ),
    ),

        // floatingActionButton: floatingCart(context),
        );
  }
}
