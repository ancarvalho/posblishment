import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/entities.dart' as e;
import 'categories_list_store.dart';

class CategoriesListPage extends StatefulWidget {
  const CategoriesListPage({super.key});

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  final store = Modular.get<CategoriesListStore>();
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
                        arguments: e.Category.empty(),
                      );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
          child: ScopedBuilder<CategoriesListStore, Failure, List<e.Category>>(
            onLoading: (context) => const CircularProgressIndicator(),
            store: store,
            onState: (context, state) {
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      Modular.to.pushNamed(
                        './category',
                        arguments: state[index],
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
    );
  }
}
