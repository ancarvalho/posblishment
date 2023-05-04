import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../pages/categories_list/categories_list_store.dart';
import '../dialog/custom_cancel_dialog.dart';
import 'category_card_store.dart';

class CategoryCardWidget extends StatefulWidget {
  final Category category;
  const CategoryCardWidget({super.key, required this.category});

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
      onTap: () {
        Modular.to.pushNamed(
          './category',
          arguments: widget.category,
        );
      },
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomCancelDialog(
              delete: () async {
                await controller.deleteCategory(widget.category.id!);
                await store.list();
              },
              name: widget.category.name,
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.all(Sizes.dp10(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Sizes.width(context) * .60,
              child: Column(
                children: [
                  Text(widget.category.name),
                  Text(widget.category.description ?? "")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}