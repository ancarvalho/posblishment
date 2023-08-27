import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/validators/validators.dart';
import 'package:management/src/presenter/pages/product/product_controller.dart';
import 'package:management/src/presenter/pages/product/product_store.dart';
import 'package:management/src/presenter/stores/categories_load_store.dart';

import '../../../domain/adapters/adapters.dart';
import '../../widgets/error/error_widget.dart';
import '../products_list/products_list_store.dart';

class ProductPage extends StatefulWidget {
  final Product? product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

// TODO Instanciate usecases, controller, and store on module
class _ProductPageState extends State<ProductPage> {
  final controller = ProductController();
  final store = Modular.get<ProductStore>();
  final productsStore = Modular.get<ProductListStore>();
  final categoriesLoadStore = Modular.get<CategoriesLoadStore>();

  late Disposer _createProductDisposer;
  late Disposer _observerCategoriesDisposer;

  @override
  void initState() {
    _createProductDisposer = store.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, error.errorMessage);
      },
      onState: (i) {
        productsStore.list();
        Navigator.of(context).canPop()
            ? Navigator.of(context).pop()
            : const DoNothingAndStopPropagationIntent();
      },
    );

    _observerCategoriesDisposer = categoriesLoadStore.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, "Need Create Categories First");
      },
    );

    categoriesLoadStore.load();
    controller.resetFields(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Navigator.of(context).canPop() ? null : const DrawerWidget(),
        appBar: AppBar(
          title: Text(
            widget.product != null ? widget.product!.name : "Criar Produto",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Reset Fields',
              onPressed: () {
                controller.resetFields(widget.product);
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
          child: SingleChildScrollView(
            child: ScopedBuilder<CategoriesLoadStore, Failure, List<Category>>(
              store: categoriesLoadStore,
              onError: (context, error) => ManagementErrorWidget(
                error: error,
                reload: categoriesLoadStore.load,
              ),
              onState: (context, state) {
                return Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: controller.codeTextController,
                        decorationName: "Código",
                        value: controller.codeTextController.text,
                        keyboardType: TextInputType.number,
                        // ERROR ON Editing on Start
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ]
                      ),
                      CustomTextFormField(
                        controller: controller.nameTextController,
                        decorationName: "Nome",
                        value: controller.nameTextController.text,
                        validator: validateNome,
                      ),
                      CustomTextFormField(
                        controller: controller.descriptionTextController,
                        decorationName: "Description",
                        value: controller.descriptionTextController.text,
                        validator: validateDescription,
                      ),
                      CustomTextFormField(
                        controller: controller.priceTextController,
                        decorationName: "Price",
                        value: controller.priceTextController.text,
                        keyboardType: TextInputType.number,
                        // ERROR ON Editing on Start
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                        // validator: validateCurrency,
                      ),
                      CustomTextFormField(
                        controller: controller.variationTextController,
                        decorationName: "Variações",
                        value: controller.variationTextController.text,
                      ),
                      CustomDropDown(
                        items: categoriesToMap(state),
                        setValue: (value) {
                          controller.categoryID = value;
                        },
                        value: controller.categoryID,
                        labelText: "Categorias",
                        validator: validateID,
                      ),
                    ],
                  ),
                );
              },
            ),
            // ScopedBuilder<ProductStore, Failure, e.Product>(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // TODO Check here
          onPressed: () {
            controller.saveChanges(widget.product?.id).then((value) =>
                value.fold(
                    (l) => displayMessageOnSnackbar(context, l.errorMessage),
                    (r) => null));
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _createProductDisposer();
    _observerCategoriesDisposer();
    super.dispose();
  }
}
