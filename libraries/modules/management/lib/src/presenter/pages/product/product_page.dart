import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/presenter/pages/product/product_controller.dart';
import 'package:management/src/presenter/pages/product/product_store.dart';

import '../../../domain/errors/management_failures.dart';
import '../../widgets/custom_text_form_field/custom_text_form_field_widget.dart';
import '../products_list/products_list_store.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

// TODO Instanciate usecases, controller, and store on module
class _ProductPageState extends State<ProductPage> {
  final controller = ProductController();
  final store = Modular.get<ProductStore>();
  final productsStore = Modular.get<ProductListStore>();

  late Disposer _disposer;

  void checkCategoryID() {
    if (widget.product.categoryId != null) {
      controller.categoryID.value = widget.product.categoryId!;
    }
  }

  @override
  void initState() {
    _disposer = store.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, error.errorMessage);
      },
      onState: (i) {
        // Navigator.of(context).pop();
      },
    );
    store.load();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.product.id != null ? widget.product.name : "Criar Produto",
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
            child: ScopedBuilder<ProductStore, Failure, List<Category>>(
              store: store,
              onError: (context, error) {
                if (error is NoDataFound) {
                  return const Center(child: Text('No Data'));
                }
                if (error is ManagementNoInternetConnection) {
                  return Center(
                    child: NoInternetWidget(
                      message: AppConstant.noInternetConnection,
                      onPressed: store.load,
                    ),
                  );
                }
                return CustomErrorWidget(message: error?.errorMessage);
              },
              onState: (context, state) {
                return Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: controller.nameTextController,
                        decorationName: "Nome",
                        value: widget.product.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe um Nome';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        controller: controller.descriptionTextController,
                        decorationName: "Description",
                        value: widget.product.description,
                      ),
                      CustomTextFormField(
                        controller: controller.priceTextController,
                        decorationName: "Price",
                        value: widget.product.price.toString(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              CurrencyInputFormatter.formatToDouble(value) ==
                                  0) {
                            return 'Informe um Valor';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        controller: controller.variationTextController,
                        decorationName: "Variações",
                        value: widget.product.variations?.join(","),
                      ),
                      DropdownButtonFormField(
                        items: state
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.id,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          controller.categoryID.value = value;
                        },
                        value: controller.categoryID.value,
                      )
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
            controller.saveChanges(widget.product.id);
            productsStore.list();
            // Navigator.of(context).pop();
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
