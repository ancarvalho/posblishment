import 'package:posblishment/domain/entities/establishment.dart';

import '../enums/themes.dart';
// import 'current_route.dart';

class Settings {
  final ThemesOptions theme;
  final bool orderSheetEnabled;
  final Establishment establishment;

  const Settings({
    this.theme = ThemesOptions.dark,
    this.orderSheetEnabled = false,
    required this.establishment,
  });

  factory Settings.empty() {
    return Settings(
      establishment: Establishment(name: ""),
    );
  }

  Settings copyWith({
    ThemesOptions? theme,
    // CurrentRoute? currentRoute,
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
      theme: ThemesOptions.values.elementAt(int.tryParse(map["theme"]) ?? 0),
      orderSheetEnabled: map["order_sheet_enabled"],
      establishment: map["establishment"] != null
          ? Establishment.fromMap(map["establishment"])
          : Establishment(name: ""),
    );
  }

  static Map<String, dynamic> toJson(Settings settings) {
    return {
      "theme": settings.theme.index.toString(),
      "order_sheet_enabled": settings.orderSheetEnabled,
      "establishment": Establishment.toJson(settings.establishment),
    };
  }
}
