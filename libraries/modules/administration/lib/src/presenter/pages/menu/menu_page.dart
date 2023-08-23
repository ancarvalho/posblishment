import 'package:administration/src/presenter/stores/products/products_store.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/menu_card/menu_card_widget.dart';

// Menu alternative would be create items with image in grid square style
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final menuStore = Modular.get<ProductStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        centerTitle: true,
      ),
      body: ScopedBuilder<ProductStore, Failure, List<Product>>(
        store: menuStore,
        onState: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return MenuWidgetCard(
                product: state[index],
              );
            },
          );
        },
      ),
    );
  }
}