import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/validators/validators.dart';
import '../../widgets/categories/categories_list_store.dart';
import 'category_controller.dart';
import 'category_store.dart';

class CategoryPage extends StatefulWidget {
  final Category? category;
  const CategoryPage({super.key, this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final controller = CategoryController();
  final store = Modular.get<CategoryStore>();

  late Disposer _disposer;

  @override
  void initState() {
    controller.resetFields(widget.category);
    _disposer = store.observer(
      onState: (i) {
        //TODO check can unpop
        // Navigator.canPop(context);
        //TODO analyse error because context does not exist due widget was disposed
        Modular.get<CategoriesListStore>().list();
        Navigator.of(context).canPop()
            ? Navigator.of(context).pop()
            : controller.resetFields(widget.category);
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
    return SafeArea(
      child: Scaffold(
        drawer: Navigator.of(context).canPop() ? null : const DrawerWidget(),
        appBar: AppBar(
          title: Text(
            widget.category != null
                ? "Atualizar ${widget.category?.name}"
                : "Criar Categoria",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Reset Fields',
              onPressed: () {
                controller.resetFields(widget.category);
              },
            ),
          ],
        ),
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
            await controller.saveChanges(widget.category?.id);
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
