import 'package:isar/isar.dart';

part 'category.g.dart';

@Collection()
@Name("categories")
class Categories {

  Id id = Isar.autoIncrement;

  late String name;
  late String description;
}
