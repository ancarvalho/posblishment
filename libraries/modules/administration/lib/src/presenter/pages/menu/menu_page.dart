import 'package:administration/src/presenter/stores/products/products_store.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/drawer/drawer_widget.dart';
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
  void initState() {
    menuStore.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Menu"),
          centerTitle: true,
        ),
        body: ScopedBuilder<ProductStore, Failure, List<Product>>(
          store: menuStore,
          onState: (context, state) {
            return Padding(
              padding: Paddings.paddingLTRB4(),
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return MenuWidgetCard(
                    product: state[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
