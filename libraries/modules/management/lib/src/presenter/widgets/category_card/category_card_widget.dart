import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../categories/categories_list_store.dart';
import '../dialog/custom_delete_dialog.dart';
import 'category_card_store.dart';

class CategoryCardWidget extends StatefulWidget {
  final Category category;
  final Function setIndex;
  const CategoryCardWidget({super.key, required this.category, required this.setIndex});

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  final store = Modular.get<CategoriesListStore>();
  final controller = Modular.get<CategoryCardStore>();

  @override
  void initState() {
    controller.observer(
      onError: (error) {
        // TODO replace by some instance
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Sizes.isMobile(context)
          ? () => Modular.to.pushNamed(
                "${PagesRoutes.category.dependsOnModule.route}${PagesRoutes.category.route}",
                arguments: widget.category,
              )
          : () => widget.setIndex(),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDeleteDialog(
              delete: () async {
                await controller.deleteCategory(widget.category.id!);
                await store.list();
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
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: Sizes.isMobile(context) ? Sizes.dp20(context) : Sizes.dp10(context)),
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
