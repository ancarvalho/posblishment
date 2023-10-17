import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/validators/validators.dart';
import '../../pages/category/category_store.dart';
import '../../widgets/categories/categories_list_store.dart';

class CategoryWidget extends StatefulWidget {
  final int? index;
  const CategoryWidget({super.key, this.index});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  // final controller = CategoryController();
  final categoryStore = Modular.get<CategoryStore>();
  final categoriesStore = Modular.get<CategoriesListStore>();

  late Disposer _disposer;
  Category? category;

  @override
  void initState() {
    if (widget.index != null) category = categoriesStore.state[widget.index!];
    categoryStore.resetFields(category);
    _disposer = categoryStore.observer(
      onState: (i) {
        //TODO check can unpop
        // Navigator.canPop(context);
        //TODO analyse error because context does not exist due widget was disposed
        Modular.get<CategoriesListStore>().list();
        Navigator.of(context).canPop()
            ? Navigator.of(context).pop()
            : categoryStore.clearFields();
      },
      onError: (error) {
        //TODO analyse error because context does not exist due widget was disposed
        displayMessageOnSnackbar(context, error.errorMessage);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // categoryStore.dispose();
    //solves 1st error but couses the observer to error
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
            child: Form(
              key: categoryStore.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller:
                        categoryStore.nameTextController,
                    decorationName: "Nome",
                    value: categoryStore
                        .nameTextController.text,
                    validator: validateNome,
                  ),
                  CustomTextFormField(
                    controller: categoryStore
                        .descriptionTextController,
                    decorationName: "Description",
                    value: categoryStore
                        .descriptionTextController.text,
                    validator: validateDescription,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await categoryStore.saveChanges(category?.id);
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
