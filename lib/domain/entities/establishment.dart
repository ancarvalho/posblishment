
import '../enums/establishment_type.dart';

class Establishment {
  final String name;
  final EstablishmentType establishmentType;

  Establishment({required this.name, this.establishmentType = EstablishmentType.restaurant});


  static Establishment fromMap(dynamic map) {
    return Establishment(
      name: map["name"],
      establishmentType: map["establishment_type"],
     
    );
  }
    static Map<String, dynamic> toJson(Establishment establishment) {
    return {
      "name": establishment.name,
      "establishment_type": establishment.establishmentType,

    };
  }
}
