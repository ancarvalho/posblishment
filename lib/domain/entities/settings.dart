import 'package:core/core.dart';
import 'package:posblishment/domain/entities/establishment.dart';

// import 'current_route.dart';

class Settings {
  final ThemesOptions theme;
  final bool orderSheetEnabled;
  final Establishment? establishment;
  final bool enablePrinter;
  final String? printerIp;
  final int? printerPort;

  const Settings({
    this.theme = ThemesOptions.dark,
    this.orderSheetEnabled = false,
    this.enablePrinter = false,
    this.printerIp,
    this.printerPort = 9100,
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
    bool? enablePrinter,
    String? printerIp,
    int? printerPort,
  }) {
    return Settings(
      theme: theme ?? this.theme,
      orderSheetEnabled: orderSheetEnabled ?? this.orderSheetEnabled,
      establishment: establishment ?? this.establishment,
      enablePrinter: enablePrinter ?? this.enablePrinter,
      printerIp: printerIp ?? this.printerIp,
      printerPort: printerPort ?? this.printerPort
    );
  }

  static Settings fromMap(dynamic map) {
    return Settings(
      theme: ThemesOptions.values.elementAt(int.tryParse(map["theme"]) ?? 0),
      orderSheetEnabled: map["order_sheet_enabled"],
      enablePrinter: map["enable_printer"],
      printerIp: map["printer_ip"],
      printerPort: map["printer_port"],
      establishment: map["establishment"] != null
          ? Establishment.fromMap(map["establishment"])
          : null,
    );
  }

  static Map<String, dynamic> toJson(Settings settings) {
    return {
      "theme": settings.theme.index.toString(),
      "order_sheet_enabled": settings.orderSheetEnabled,
      "enable_printer": settings.enablePrinter,
      "printer_ip": settings.printerIp,
      "printer_port": settings.printerPort,
      if (settings.establishment != null)
        "establishment": Establishment.toJson(settings.establishment!),
    };
  }
}
