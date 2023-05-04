import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/presenter/widgets/category_card/category_card_store.dart';

import '../../widgets/category_card/category_card_widget.dart';
import 'categories_list_store.dart';

class CategoriesListPage extends StatefulWidget {
  const CategoriesListPage({super.key});

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  final store = Modular.get<CategoriesListStore>();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Categorias"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search For Category',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Create New Category',
              onPressed: () {
                Modular.to.pushNamed(
                  './category',
                  // TODO Check if dispose is being called on controllers
                  arguments: Category.empty(),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
          child: RefreshIndicator(
            onRefresh: reload,
            child: ScopedBuilder<CategoriesListStore, Failure, List<Category>>(
              onLoading: (context) => const CircularProgressIndicator(),
              store: store,
              onState: (context, state) {
                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {

                    return CategoryCardWidget(
                      category: state[index],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
