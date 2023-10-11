import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/categories/categories_widget.dart';
import '../../widgets/category/category_widget.dart';

class CategoriesListPage extends StatefulWidget {
  const CategoriesListPage({super.key});

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  final index = ValueNotifier<int?>(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Categorias"),
          centerTitle: true,
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.search),
            //   tooltip: 'Search For Category',
            //   onPressed: () {},
            // ),
            if (Sizes.isMobile(context))
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Create New Category',
                onPressed: () {
                  Modular.to.pushNamed(
                    "${PagesRoutes.category.dependsOnModule.route}${PagesRoutes.category.route}",
                    // TODO Check if dispose is being called on controllers
                  );
                },
              ),
          ],
        ),
        body: Sizes.isMobile(context)
            ? const CategoriesWidget()
            : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CategoriesWidget(
                      setIndex: (i) {
                        index.value = i;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    // key: UniqueKey(),
                    flex: 3,
                    child: CategoryWidget(
                      index: index.value,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
