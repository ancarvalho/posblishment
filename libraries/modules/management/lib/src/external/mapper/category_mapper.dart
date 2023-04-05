// import '../../domain/entities/category.dart';
// import 'product_mapper.dart';

// class CategoryMapper {
//   static List<Category> fromMapList(Map<String, dynamic> map) =>
//       List<Category>.from(
//         (map["data"] ?? []).map(CategoryMapper.fromMap),
//       );

//   static Category fromMap(dynamic map) {
//     return Category(
//       id: map["id"],
//       name: map["name"],
//       description: map["description"],
//       products: (map["products"] ?? []).map(ProductMapper.fromMapList),
//     );
//   }

//   static Map<String, dynamic> toJson(Category category) {
//     return {
//       "id": category.id,
//       "name": category.name,
//       "description": category.description,
//       // "products": category.products,
//     };
//   }
// }
