import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/presenter/widgets/category_card/category_card_store.dart';

import '../../pages/category/category_store.dart';
import '../../widgets/category_card/category_card_widget.dart';
import '../../widgets/error/error_widget.dart';
import 'categories_list_store.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key, this.setIndex});
  final Function(int index)? setIndex;
  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final store = Modular.get<CategoriesListStore>();
  final categoryStore = Modular.get<CategoryStore>();
  final controller = Modular.get<CategoryCardStore>();

  Future<void> reload() async {
    await store.list();
  }

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: reload,
      child: ScopedBuilder<CategoriesListStore, Failure, List<Category>>(
        onLoading: (context) => const LoadingWidget(),
        onError: (context, error) => ManagementErrorWidget(
          error: error,
          reload: reload,
        ),
        store: store,
        onState: (context, state) {
          return Padding(
            padding: Paddings.paddingLTRB4(),
            child: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                return CategoryCardWidget(
                    category: state[index],
                    index: index,
                    setIndex: () {
                      widget.setIndex!(index);
                      categoryStore.resetFields(store.state[index]);
                    });
              },
            ),
          );
        },
      ),
    );
  }
}
