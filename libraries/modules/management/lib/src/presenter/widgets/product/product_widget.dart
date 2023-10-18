import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/validators/validators.dart';
import 'package:management/src/presenter/pages/product/product_store.dart';
import 'package:management/src/presenter/stores/categories_load_store.dart';
import 'package:management/src/presenter/widgets/tags.dart';

import '../../../domain/adapters/adapters.dart';
import '../../pages/product/product_controller.dart';
import '../../widgets/error/error_widget.dart';
import '../../widgets/products/products_list_store.dart';

class ProductWidget extends StatefulWidget {

  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

// TODO Instanciate usecases, controller, and store on module
class _ProductWidgetState extends State<ProductWidget> {
  final productStore = Modular.get<ProductStore>();
  final categoriesLoadStore = Modular.get<CategoriesLoadStore>();
  // final productsStore = Modular.get<ProductListStore>();

  final productController = Modular.get<ProductController>();

  late Disposer _createProductDisposer;
  late Disposer _observerCategoriesDisposer;

  Product? product;

  @override
  void initState() {
  
    _createProductDisposer = productStore.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, error.errorMessage);
      },
      onState: (i) {
        Modular.get<ProductListStore>().list();
        Navigator.of(context).canPop()
            ? Navigator.of(context).pop()
            : productController.clearFields();
      },
    );

    _observerCategoriesDisposer = categoriesLoadStore.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, "Need Create Categories First");
      },
    );

    categoriesLoadStore.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ScopedBuilder<CategoriesLoadStore, Failure, List<Category>>(
          store: categoriesLoadStore,
          onError: (context, error) => ManagementErrorWidget(
            error: error,
            reload: categoriesLoadStore.load,
          ),
          onState: (context, state) {
            return Padding(
              padding: Paddings.paddingForm(),
              child: Form(
                key: productController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: productController.codeTextController,
                      decorationName: "Código",
                      value: productController.codeTextController.text,
                      keyboardType: TextInputType.number,
                      // ERROR ON Editing on Start
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CustomTextFormField(
                      controller: productController.nameTextController,
                      decorationName: "Nome",
                      value: productController.nameTextController.text,
                      validator: validateNome,
                    ),
                    CustomTextFormField(
                      controller: productController.descriptionTextController,
                      decorationName: "Description",
                      value: productController.descriptionTextController.text,
                      validator: validateDescription,
                    ),
                    CustomTextFormField(
                      controller: productController.priceTextController,
                      decorationName: "Price",
                      value: productController.priceTextController.text,
                      keyboardType: TextInputType.number,
                      // ERROR ON Editing on Start
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                      // validator: validateCurrency,
                    ),
                    CustomDropDown(
                      items: categoriesToMap(state),
                      setValue: (value) {
                        productController.categoryID = value;
                      },
                      value: productController.categoryID,
                      labelText: "Categorias",
                      validator: validateID,
                    ),
                    const SizedBox(height: 10),
                    Tags(
                      textfieldTagsController:
                          productController.variationTextController,
                      items: product?.variations?.split(","),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // ScopedBuilder<ProductStore, Failure, e.Product>(),
      ),
      floatingActionButton: FloatingActionButton(
        // TODO Check here
        onPressed: () {
          productController.saveChanges()
          .then((value) => eitherDisplayError(context, value));
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    // productStore.dispose();
    _createProductDisposer();
    _observerCategoriesDisposer();
    super.dispose();
  }
}
