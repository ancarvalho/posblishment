import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:internal_database/internal_database.dart';
import 'package:management/src/presenter/pages/categories_list/categories_list_controller.dart';

import '../../widgets/dialog/custom_cancel_dialog.dart';
import 'categories_list_store.dart';

class CategoriesListPage extends StatefulWidget {
  const CategoriesListPage({super.key});

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  final store = Modular.get<CategoriesListStore>();
  final controller = Modular.get<CategoriesListController>();

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
                    return GestureDetector(
                      onTap: () {
                        Modular.to.pushNamed(
                          './category',
                          arguments: state[index],
                        );
                      },
                      onDoubleTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomCancelDialog(
                              delete: () async {
                                await controller.deleteCategory(state[index].id!);
                                await reload();
                              },
                              id: state[index].id!,
                              name: state[index].name,
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
                                  Text(state[index].name),
                                  Text(state[index].description ?? "")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
