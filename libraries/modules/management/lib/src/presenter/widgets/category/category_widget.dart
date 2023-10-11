import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/validators/validators.dart';
import '../../pages/category/category_controller.dart';
import '../../pages/category/category_store.dart';
import '../../widgets/categories/categories_list_store.dart';

class CategoryWidget extends StatefulWidget {
  final int? index;
  const CategoryWidget({super.key, this.index});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final controller = CategoryController();
  final store = Modular.get<CategoryStore>();
  final categoriesStore = Modular.get<CategoriesListStore>();

  late Disposer _disposer;
  Category? category;

  @override
  void initState() {
    
    _disposer = store.observer(
      onState: (i) {
        //TODO check can unpop
        // Navigator.canPop(context);
        //TODO analyse error because context does not exist due widget was disposed
        Modular.get<CategoriesListStore>().list();
        Navigator.of(context).canPop()
            ? Navigator.of(context).pop()
            : controller.clearFields();
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
    controller.dispose();
    //solves 1st error but couses the observer to error
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index != null) category = categoriesStore.state[widget.index!];
    controller.resetFields(category);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await controller.saveChanges(category?.id);
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
