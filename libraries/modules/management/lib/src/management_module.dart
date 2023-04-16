
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/domain/use_cases/delete_category.dart';
import 'package:management/src/domain/use_cases/delete_product.dart';
import 'package:management/src/presenter/pages/category/category_controller.dart';
import 'package:management/src/presenter/pages/product/product_store.dart';

import 'domain/repositories/management_repository.dart';
import 'domain/use_cases/create_category.dart';
import 'domain/use_cases/create_product.dart';
import 'domain/use_cases/list_all_categories.dart';
import 'domain/use_cases/list_all_products.dart';
import 'domain/use_cases/update_category.dart';
import 'domain/use_cases/update_product.dart';
import 'infra/repositories/management_repository_dummy_impl.dart';
// all categories
import 'presenter/pages/categories_list/categories_list_controller.dart';
import 'presenter/pages/categories_list/categories_list_page.dart';
import 'presenter/pages/categories_list/categories_list_store.dart';
//category
import 'presenter/pages/category/category_page.dart';
//product
import 'presenter/pages/product/product_controller.dart';
import 'presenter/pages/product/product_page.dart';
// all products 
import 'presenter/pages/products_list/products_list_controller.dart';
import 'presenter/pages/products_list/products_list_page.dart';
import 'presenter/pages/products_list/products_list_store.dart';

class ManagementModule extends Module {
  @override
  final List<Bind> binds = [

    Bind.lazySingleton((i) => ProductListStore(i()),export: true,),
    Bind.lazySingleton((i) => ProductStore(i()),export: true,),
    Bind.lazySingleton((i) => CategoriesListStore(i()),export: true,),

    Bind.lazySingleton((i) => ProductController(i(), i()),export: true,),
    Bind.lazySingleton((i) => CategoryController(i(), i()),export: true,),
    Bind.lazySingleton((i) => CategoriesListController(i(), ),export: true,),
    Bind.lazySingleton((i) => ProductsListController(i(), ),export: true,),

    Bind.lazySingleton<ManagementRepository>((i) => ManagementRepositoryDummyImpl(i()),),


    Bind.lazySingleton<IListAllProducts>((i) => ListAllProducts(i()),),
    Bind.lazySingleton<ICreateProduct>((i) => CreateProduct(i()),),
    Bind.lazySingleton<IUpdateProduct>((i) => UpdateProduct(i()),),
    Bind.lazySingleton<IDeleteProduct>((i) => DeleteProduct(i()),),
    //Categories
    Bind.lazySingleton<IListAllCategories>((i) => ListAllCategories(i()),),
    Bind.lazySingleton<ICreateCategory>((i) => CreateCategory(i()),),
    Bind.lazySingleton<IUpdateCategory>((i) => UpdateCategory(i()),),
    Bind.lazySingleton<IDeleteCategory>((i) => DeleteCategory(i()),),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/all_products', child: (_, args) => const ProductsListPage()),
    ChildRoute('/product', child: (_, args) => ProductPage(product: args.data,)),
    ChildRoute('/all_categories', child: (_, args) => const CategoriesListPage()),
    ChildRoute('/category', child: (_, args) => CategoryPage(category: args.data,)),
  ];
}
