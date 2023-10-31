import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/presenter/pages/product/product_controller.dart';
import 'package:management/src/presenter/pages/product/product_store.dart';
import 'package:management/src/presenter/stores/categories_load_store.dart';
import 'package:management/src/presenter/widgets/product/product_widget.dart';

import '../../widgets/products/products_list_store.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

// TODO Instanciate usecases, controller, and store on module
class _ProductPageState extends State<ProductPage> {
  // final productStore = Modular.get<ProductStore>();
  // final productsStore = Modular.get<ProductListStore>();

  final productController = Modular.get<ProductController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Navigator.of(context).canPop() ? null : const DrawerWidget(),
        appBar: AppBar(
          title: Text(
            productController.index != null
                ? "Atualizar ${productController.nameTextController.text}"
                : "Criar Produto",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Reset Fields',
              onPressed: productController.resetFields,
            ),
          ],
        ),
        body: const ProductWidget(),
      ),
    );
  }

  @override
  void dispose() {
    // productStore.dispose();
    // _createProductDisposer();
    // _observerCategoriesDisposer();
    super.dispose();
  }
}
