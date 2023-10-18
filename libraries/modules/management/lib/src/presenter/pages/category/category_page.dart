import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/presenter/widgets/category/category_widget.dart';

import 'category_controller.dart';

class CategoryPage extends StatefulWidget {
  // final int? index;
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final categoryController = Modular.get<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Navigator.of(context).canPop() ? null : const DrawerWidget(),
        appBar: AppBar(
          title: Text(
            categoryController.index != null
                ? "Atualizar ${categoryController.nameTextController.text}"
                : "Criar Categoria",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Reset Fields',
              onPressed: categoryController.resetFields,
            ),
          ],
        ),
        body: const CategoryWidget(),
      ),
    );
  }
}
