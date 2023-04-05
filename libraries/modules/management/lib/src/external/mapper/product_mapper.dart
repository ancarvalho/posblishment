// import '../../domain/entities/product.dart';

// class ProductMapper {
//   static List<Product> fromMapList(Map<String, dynamic> map) =>
//       List<Product>.from(
//         (map["data"] ?? []).map(ProductMapper.fromMap),
//       );

//   static Product fromMap(dynamic map) {
//     return Product(
//       id: map["id"],
//       code: map["code"],
//       name: map["name"],
//       description: map["description"],
//       unitValue: map["unit_value"],
//       variations: map["variations"],
//     );
//   }

//   static Map<String, dynamic> toJson(Product product) {
//     return {
//       "id": product.id,
//       "code": product.code,
//       "name": product.name,
//       "description": product.description,
//       "unit_value": product.unitValue,
//       "variations": product.variations,
//     };
//   }
// }
