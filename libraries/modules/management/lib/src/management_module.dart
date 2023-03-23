
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/management_repository.dart';
import 'domain/use_cases/list_all_categories.dart';
import 'domain/use_cases/list_all_products.dart';
import 'infra/repositories/management_repository_dummy_impl.dart';
// all categories
import 'presenter/pages/categories_list/categories_list_page.dart';
import 'presenter/pages/categories_list/categories_list_store.dart';
//category
import 'presenter/pages/category/category_page.dart';
//product
import 'presenter/pages/product/product_page.dart';
// all products 
import 'presenter/pages/products_list/products_list_page.dart';
import 'presenter/pages/products_list/products_list_store.dart';

class ManagementModule extends Module {
  @override
  final List<Bind> binds = [

    Bind.lazySingleton((i) => ProductListStore(i()),export: true,),
    Bind.lazySingleton((i) => CategoriesListStore(i()),export: true,),

    Bind.lazySingleton<ManagementRepository>((_) => ManagementRepositoryDummyImpl(),),


    Bind.lazySingleton<IListAllProducts>((i) => ListAllProducts(i()),),
    Bind.lazySingleton<IListAllCategories>((i) => ListAllCategories(i()),),

  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/all_products', child: (_, args) => const ProductsListPage()),
    ChildRoute('/product', child: (_, args) => ProductPage(product: args.data,)),
    ChildRoute('/all_categories', child: (_, args) => const CategoriesListPage()),
    ChildRoute('/category', child: (_, args) => CategoryPage(category: args.data,)),
  ];
}
