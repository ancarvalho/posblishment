import 'package:posblishment/domain/entities/establishment.dart';

import 'current_route.dart';

class Settings {
  final String theme;
  final CurrentRoute currentRoute;
  final bool orderSheetEnabled;
  final Establishment establishment;

  const Settings({
    this.theme = "",
    required this.currentRoute,
    this.orderSheetEnabled = false,
    required this.establishment,
  });

  factory Settings.empty() {
    return Settings(
      currentRoute: CurrentRoute(),
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
      currentRoute: currentRoute ?? this.currentRoute,
      orderSheetEnabled: orderSheetEnabled ?? this.orderSheetEnabled,
      establishment: establishment ?? this.establishment,
    );
  }

  static Settings fromMap(dynamic map) {
    return Settings(
      theme: map["theme"],
      currentRoute: map["current_route"] != null
          ? CurrentRoute.fromMap(map["current_route"])
          : CurrentRoute(),
      orderSheetEnabled: map["order_sheet_enabled"],
      establishment: map["establishment"] != null
          ? Establishment.fromMap(map["establishment"])
          : Establishment(name: ""),
    );
  }

  static Map<String, dynamic> toJson(Settings settings) {
    return {
      "theme": settings.theme,
      "current_route": CurrentRoute.toJson(settings.currentRoute),
      "order_sheet_enabled": settings.orderSheetEnabled,
      "establishment": Establishment.toJson(settings.establishment),
    };
  }
}
