import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/presenter/pages/category/category_controller.dart';

import '../../../domain/use_cases/usecases.dart';
import '../categories/categories_list_store.dart';
import '../dialog/custom_delete_dialog.dart';

class CategoryCardWidget extends StatefulWidget {
  final Category category;
  // final Function? setIndex;
  final int index;
  const CategoryCardWidget(
      {super.key, required this.category, required this.index});

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  // final store = Modular.get<CategoriesListStore>();
  final deleteCategory = Modular.get<IDeleteCategory>();
  final categoryController = Modular.get<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        categoryController
          ..index = widget.index
          ..resetFields();

        if (Sizes.isMobile(context)) {
          Modular.to.pushNamed(
            "${PagesRoutes.category.dependsOnModule.route}${PagesRoutes.category.route}",
            // arguments: widget.index,
          );
        }
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDeleteDialog(
              delete: () async {
                await deleteCategory.call(widget.category.id!).then(
                      (value) => eitherDisplayError(context, value),
                    );
                await Modular.get<CategoriesListStore>().list();
              },
              name: widget.category.name,
            );
          },
        );
      },
      child: Card(
        child: Padding(
          padding: Paddings.paddingLTRB8(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    widget.category.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: Sizes.isMobile(context)
                            ? Sizes.dp20(context)
                            : Sizes.dp10(context),),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.category.description ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
