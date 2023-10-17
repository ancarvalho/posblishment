import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/presenter/widgets/category/category_widget.dart';

import '../../widgets/categories/categories_list_store.dart';
import 'category_store.dart';

class CategoryPage extends StatefulWidget {
  final int? index;
  const CategoryPage({super.key, this.index});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // final controller = CategoryController();
  final categoryStore = Modular.get<CategoryStore>();
  final categoriesStore = Modular.get<CategoriesListStore>();

  // late Disposer _disposer;

  Category? category;

  @override
  void initState() {
    if (widget.index != null) category = categoriesStore.state[widget.index!];
    categoryStore.resetFields(category);
    // _disposer = categoryStore.observer(
    //   onState: (i) {
    //     //TODO check can unpop
    //     // Navigator.canPop(context);
    //     //TODO analyse error because context does not exist due widget was disposed
    //     Modular.get<CategoriesListStore>().list();
    //     Navigator.of(context).canPop()
    //         ? Navigator.of(context).pop()
    //         : categoryStore.resetFields(category);
    //   },
    //   onError: (error) {
    //     //TODO analyse error because context does not exist due widget was disposed
    //     displayMessageOnSnackbar(context, error.errorMessage);
    //   },
    // );
    super.initState();
  }

  @override
  void dispose() {
    // categoryStore.dispose();
    //solves 1st error but couses the observer to error
    // _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Navigator.of(context).canPop() ? null : const DrawerWidget(),
          appBar: AppBar(
            title: Text(
              category != null
                  ? "Atualizar ${category?.name}"
                  : "Criar Categoria",
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.clear),
                tooltip: 'Reset Fields',
                onPressed: () {
                  categoryStore.resetFields(category);
                },
              ),
            ],
          ),
          body:  CategoryWidget(index: widget.index,),),
    );
  }
}
