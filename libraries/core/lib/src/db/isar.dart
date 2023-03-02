import 'package:isar/isar.dart';

import '../entities/category.dart';
import '../entities/product.dart';

class IsarClient {
  Future<Isar> get isar => _initIsar();

  Future<Isar> _initIsar() async {
    return Isar.open(
      [
        CategoriesSchema,
        ProductSchema,
      ],
      directory: "",
    );
  }


}
