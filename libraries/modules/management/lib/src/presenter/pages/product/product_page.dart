import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/presenter/pages/product/product_store.dart';
import 'package:management/src/presenter/stores/categories_load_store.dart';
import 'package:management/src/presenter/widgets/product/product_widget.dart';

import '../../widgets/products/products_list_store.dart';

class ProductPage extends StatefulWidget {
  final int? index;
  const ProductPage({super.key, this.index});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

// TODO Instanciate usecases, controller, and store on module
class _ProductPageState extends State<ProductPage> {
  final productStore = Modular.get<ProductStore>();
  final productsStore = Modular.get<ProductListStore>();
  // final categoriesLoadStore = Modular.get<CategoriesLoadStore>();

  // late Disposer _createProductDisposer;
  // late Disposer _observerCategoriesDisposer;

  Product? product;

  @override
  void initState() {
    if (widget.index != null) product = productsStore.state[widget.index!];

    // _createProductDisposer = productStore.observer(
    //   onError: (error) {
    //     displayMessageOnSnackbar(context, error.errorMessage);
    //   },
    //   onState: (i) {
    //     Modular.get<ProductListStore>().list();
    //     Navigator.of(context).canPop()
    //         ? Navigator.of(context).pop()
    //         : productStore.productController.resetFields(product);
    //   },
    // );

    // productStore.productController.addListener(() {
    //   setState(() {});
    // });

    // _observerCategoriesDisposer = categoriesLoadStore.observer(
    //   onError: (error) {
    //     displayMessageOnSnackbar(context, "Need Create Categories First");
    //   },
    // );

    // categoriesLoadStore.load();
    // productStore.productController.resetFields(product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Navigator.of(context).canPop() ? null : const DrawerWidget(),
        appBar: AppBar(
          title: Text(
            product != null ? product!.name : "Criar Produto",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Reset Fields',
              onPressed: () {
                productStore.resetFields(product);
              },
            ),
          ],
        ),
        body: ProductWidget(index: widget.index,)
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
