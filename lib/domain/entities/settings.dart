import 'package:posblishment/domain/entities/establishment.dart';

import 'current_route.dart';

class Settings {
  final String theme;

  final bool orderSheetEnabled;
  final Establishment establishment;

  const Settings({
    this.theme = "",
    this.orderSheetEnabled = false,
    required this.establishment,
  });

  factory Settings.empty() {
    return Settings(
      establishment: Establishment(name: ""),
    );
  }

  Settings copyWith({
    String? theme,
    CurrentRoute? currentRoute,
    bool? orderSheetEnabled,
    Establishment? establishment,
  }) {
    return Settings(
      theme: theme ?? this.theme,
      orderSheetEnabled: orderSheetEnabled ?? this.orderSheetEnabled,
      establishment: establishment ?? this.establishment,
    );
  }

  static Settings fromMap(dynamic map) {
    return Settings(
      theme: map["theme"],

      orderSheetEnabled: map["order_sheet_enabled"],
      establishment: map["establishment"] != null
          ? Establishment.fromMap(map["establishment"])
          : Establishment(name: ""),
    );
  }

  static Map<String, dynamic> toJson(Settings settings) {
    return {
      "theme": settings.theme,
      "order_sheet_enabled": settings.orderSheetEnabled,
      "establishment": Establishment.toJson(settings.establishment),
    };
  }
}
