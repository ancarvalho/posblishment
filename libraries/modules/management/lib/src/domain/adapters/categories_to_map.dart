import 'package:core/core.dart';

Map<String, String> categoriesToMap(List<Category> categories) {
  final map = <String, String>{
    for (var category in categories) category.id!: category.name
  };

  // Map<String, String> peopleMap = Map.fromIterable(
  //   categories,
  //   key: (category) => category.id,
  //   value: (category) => category.name,
  // );

  return map;
}
