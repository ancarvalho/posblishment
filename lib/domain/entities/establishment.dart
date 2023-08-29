import '../enums/establishment_type.dart';

class Establishment {
  final String name;
  final EstablishmentType establishmentType;

  Establishment({
    required this.name,
    this.establishmentType = EstablishmentType.restaurant,
  });

  static Establishment fromMap(dynamic map) {
    return Establishment(
      name: map["name"],
      establishmentType: EstablishmentType.values
          .elementAt(int.tryParse(map["establishment_type"]) ?? 0),
    );
  }

  static Map<String, dynamic> toJson(Establishment establishment) {
    return {
      "name": establishment.name,
      "establishment_type": establishment.establishmentType.index.toString(),
    };
  }

  Establishment copyWith({
    String? name,
    EstablishmentType? establishmentType,
  }) {
    return Establishment(
      name: name ?? this.name,
      establishmentType: establishmentType ?? this.establishmentType,
    );
  }
}
