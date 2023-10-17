import 'package:core/core.dart';

class EstablishmentSettings {
  final String id;
  final String name;
  final String? description;
  final EstablishmentTypes establishmentType;
  final String? address;
  final String? imageSrc;
  final bool enableOrderSheet;
  final bool enableWideViewMode;
  final bool printerEnabled;
  final String? printerIp;
  final int? printerPort;
  final ThemesOptions theme;
  final DateTime createdAt;
  final DateTime? updatedAt;

  EstablishmentSettings({
    required this.id,
    required this.name,
    this.description,
    this.establishmentType = EstablishmentTypes.restaurant,
    this.address,
    this.imageSrc,
    required this.enableOrderSheet,
    required this.enableWideViewMode,
    required this.printerEnabled,
    this.printerIp,
    this.printerPort,
    this.theme = ThemesOptions.dark,
    required this.createdAt,
    this.updatedAt,
  });
}

class NewEstablishmentSettings {
  final String name;
  final String? description;
  final EstablishmentTypes establishmentType;
  final String? address;
  final String? imageSrc;
  final bool enableOrderSheet;
  final bool enableWideViewMode;
  final bool printerEnabled;
  final String? printerIp;
  final int? printerPort;
  final ThemesOptions theme;

  NewEstablishmentSettings({
    required this.name,
    this.description,
    required this.establishmentType,
    this.address,
    this.imageSrc,
    required this.enableOrderSheet,
    required this.enableWideViewMode,
    required this.printerEnabled,
    this.printerIp,
    this.printerPort,
    required this.theme,
  });
}
