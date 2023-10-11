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
import 'package:management/src/presenter/widgets/tags.dart';

import '../../../domain/adapters/adapters.dart';
import '../../widgets/error/error_widget.dart';
import '../../widgets/products/products_list_store.dart';

class ProductWidget extends StatefulWidget {
  final int? index;
  // final Function reset
  const ProductWidget({super.key, this.index});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

// TODO Instanciate usecases, controller, and store on module
class _ProductWidgetState extends State<ProductWidget> {
  final controller = ProductController();
  final productStore = Modular.get<ProductStore>();
  final categoriesLoadStore = Modular.get<CategoriesLoadStore>();
  final productsStore = Modular.get<ProductListStore>();

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
            : controller.clearFields();
      },
    );

    controller.addListener(() {
      setState(() {});
    });

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
    product = widget.index != null ? productsStore.state[widget.index!] : null;
    controller.resetFields(product);
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
                      ],
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
                    CustomDropDown(
                      items: categoriesToMap(state),
                      setValue: (value) {
                        controller.categoryID = value;
                      },
                      value: controller.categoryID,
                      labelText: "Categorias",
                      validator: validateID,
                    ),
                    const SizedBox(height: 10),
                    Tags(
                        textfieldTagsController:
                            controller.variationTextController,
                        items: product?.variations?.split(","),),
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
          controller
              .saveChanges(product?.id)
              .then((value) => eitherDisplayError(context, value));
        },
        child: const Icon(Icons.save),
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
