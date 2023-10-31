import 'package:core/core.dart';

class Establishment {
  final String name;
  final String? location;
  final String? imagePath;
  final EstablishmentTypes establishmentType;

  Establishment({
    this.name = "Posblishment",
    this.location,
    this.imagePath,
    this.establishmentType = EstablishmentTypes.restaurant,
  });


  factory Establishment.empty() {
    return Establishment();
  }


  static Establishment fromMap(dynamic map) {
    return Establishment(
      name: map["name"],
      location: map["location"],
      imagePath: map["image_path"],
      establishmentType: EstablishmentTypes.values
          .elementAt(int.tryParse(map["establishment_type"]) ?? 0),
    );
  }



  static Map<String, dynamic> toJson(Establishment establishment) {
    return {
      "name": establishment.name,
      "location": establishment.location,
      "image_path": establishment.imagePath,
      "establishment_type": establishment.establishmentType.index.toString(),
    };
  }

  Establishment copyWith({
    String? name,
    String? location,
    String? imagePath,
    EstablishmentTypes? establishmentType,
  }) {
    return Establishment(
      name: name ?? this.name,
      location: location,
      imagePath: imagePath,
      establishmentType: establishmentType ?? this.establishmentType,
    );
  }
}
