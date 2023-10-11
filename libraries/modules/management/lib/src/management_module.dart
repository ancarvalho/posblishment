
import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/domain/use_cases/usecases.dart';
import 'package:management/src/presenter/pages/bill_type/bill_type_page.dart';
import 'package:management/src/presenter/pages/bill_types/bill_types_page.dart';
import 'package:management/src/presenter/pages/category/category_controller.dart';
import 'package:management/src/presenter/pages/product/product_store.dart';
import 'package:management/src/presenter/stores/categories_load_store.dart';
import 'package:management/src/presenter/widgets/bill_type/bill_type_store.dart';
import 'package:management/src/presenter/widgets/bill_types/bill_types_store.dart';

import 'domain/repositories/management_repository.dart';
//
import 'infra/data_source/management_data_source_internal.dart';
import 'infra/repositories/management_repository_impl.dart';
import 'internal/data_source/management_data_source_internal_impl.dart';
//
//category
import 'presenter/pages/categories_list/categories_list_page.dart';
import 'presenter/pages/category/category_page.dart';
import 'presenter/pages/category/category_store.dart';
//products
import 'presenter/pages/product/product_controller.dart';
import 'presenter/pages/product/product_page.dart';
import 'presenter/pages/products_list/products_list_page.dart';
import 'presenter/widgets/categories/categories_list_store.dart';
// all categories
import 'presenter/widgets/category_card/category_card_store.dart';
// all products 
import 'presenter/widgets/product_card/product_card_store.dart';
import 'presenter/widgets/products/products_list_store.dart';

class ManagementModule extends Module {

  @override
  final List<Bind> binds = [

    Bind.lazySingleton((i) => ProductListStore(i()),export: true,),
    Bind.lazySingleton((i) => ProductStore(i(), i()),export: true,),
    Bind.lazySingleton((i) => CategoriesLoadStore( i()),export: true,),
    Bind.lazySingleton((i) => CategoriesListStore(i()),export: true,),
    Bind.lazySingleton((i) => CategoryStore(i(), i()),export: true,),


    Bind.lazySingleton((i) => ProductController(),export: true,),
    Bind.lazySingleton((i) => CategoryController(),export: true,),
    Bind.lazySingleton((i) => CategoryCardStore(i(), ),export: true,),
    Bind.lazySingleton((i) => ProductCardStore(i(), ),export: true,),


    Bind.lazySingleton((i) => BillTypeStore(i(), ),export: true,),
    Bind.lazySingleton((i) => BillTypesStore(i(), ),export: true,),

    Bind.lazySingleton<ManagementRepository>((i) => ManagementRepositoryImpl(i()),),

    Bind.lazySingleton<ManagementDataSource>((i) => ManagementDataSourceInternalImpl(i()),),

    Bind.lazySingleton<IListAllProducts>((i) => ListAllProducts(i()),),
    Bind.lazySingleton<ICreateProduct>((i) => CreateProduct(i()),),
    Bind.lazySingleton<IUpdateProduct>((i) => UpdateProduct(i()),),
    Bind.lazySingleton<IDeleteProduct>((i) => DeleteProduct(i()),),
    //Categories
    Bind.lazySingleton<IListAllCategories>((i) => ListAllCategories(i()),),
    Bind.lazySingleton<ICreateCategory>((i) => CreateCategory(i()),),
    Bind.lazySingleton<IUpdateCategory>((i) => UpdateCategory(i()),),
    Bind.lazySingleton<IDeleteCategory>((i) => DeleteCategory(i()),),

    Bind.lazySingleton<ICreateOrUpdateBillType>((i) => CreateOrUpdateBillType(i()),),
    Bind.lazySingleton<IDeleteBillType>((i) => DeleteBillType(i()),),
    Bind.lazySingleton<IGetBillTypes>((i) => GetBillTypes(i()),),
    Bind.lazySingleton<ISetBillTypeDefault>((i) => SetBillTypeDefault(i()),),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(PagesRoutes.products.route, child: (_, args) => const ProductsListPage()),
    ChildRoute(PagesRoutes.product.route, child: (_, args) => ProductPage(product: args.data,)),
    ChildRoute(PagesRoutes.categories.route, child: (_, args) => const CategoriesListPage()),
    ChildRoute(PagesRoutes.category.route, child: (_, args) => CategoryPage(category: args.data,)),

    ChildRoute(PagesRoutes.billType.route, child: (_, args) =>  BillTypePage(index: args.data,)),
    ChildRoute(PagesRoutes.billTypes.route, child: (_, args) => const BillTypesPage()),
  ];

  
}
