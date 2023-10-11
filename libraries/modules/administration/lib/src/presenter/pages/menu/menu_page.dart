import 'package:administration/src/presenter/stores/products/products_store.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/menu_card/menu_card_widget.dart';
import '../../widgets/search/search_engine.dart';
import '../cart/cart_store.dart';

// Menu alternative would be create items with image in grid square style
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final menuStore = Modular.get<ProductStore>();
  final cartStore = Modular.get<CartStore>();

  late final Disposer _cartStoreDisposer;

  @override
  void initState() {
    menuStore.getAllProducts();
    _cartStoreDisposer = cartStore.observer(
      onLoading: (loading) => setState(() {}),
    );
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
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchEngine());
              },
            ),
          ],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.pushNamed(
              "${PagesRoutes.cart.dependsOnModule.route}${PagesRoutes.cart.route}",
            );
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Text(cartStore.count.toString()),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                child: Icon(Icons.shopping_cart),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cartStoreDisposer();
    super.dispose();
  }
}
