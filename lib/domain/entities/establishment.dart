
import 'package:core/core.dart';

class Establishment {
  final String name;
  final EstablishmentTypes establishmentType;

  Establishment({
    required this.name,
    this.establishmentType = EstablishmentTypes.restaurant,
  });

  static Establishment fromMap(dynamic map) {
    return Establishment(
      name: map["name"],
      establishmentType: EstablishmentTypes.values
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
    EstablishmentTypes? establishmentType,
  }) {
    return Establishment(
      name: name ?? this.name,
      establishmentType: establishmentType ?? this.establishmentType,
    );
  }
}
