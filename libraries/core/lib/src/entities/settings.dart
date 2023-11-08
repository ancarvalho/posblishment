import 'package:core/core.dart';


// import 'current_route.dart';

class Settings {
  // final ThemesOptions theme;
  // final bool orderSheetEnabled;
  // TODO a way only printer with ip could connect
  final Establishment? establishment;
  final PrinterSettings? printerSettings;
  final Customization? customization;

  // final bool enablePrinter;
  // final String? printerIp;
  // final int? printerPort;
  // final bool enableWideMode;
  // final String? imagePath;
  //

  const Settings({
    // this.theme = ThemesOptions.dark,
    // this.orderSheetEnabled = false,
    // this.enablePrinter = false,
    // this.printerIp,
    // this.printerPort = 9100,
    required this.establishment,
    required this.customization,
    required this.printerSettings,
    // this.enableWideMode = false,
    // this.imagePath,
  });

  factory Settings.empty() {
    return Settings(
      establishment: Establishment.empty(),
      customization: Customization.empty(),
      printerSettings: PrinterSettings.empty(),
    );
  }

  Settings copyWith({
    ThemesOptions? theme,
    // CurrentRoute? currentRoute,
    // bool? orderSheetEnabled,
    Establishment? establishment,
    Customization? customization,
    PrinterSettings? printerSettings,
    // bool? enablePrinter,
    // String? printerIp,
    // int? printerPort,
    // bool? enableWideMode,
    // String? imagePath,
  }) {
    return Settings(
      // theme: theme ?? this.theme,
      // orderSheetEnabled: orderSheetEnabled ?? this.orderSheetEnabled,
      establishment: establishment ?? this.establishment,
      customization: customization ?? this.customization,
      printerSettings: printerSettings ?? this.printerSettings,
      // enablePrinter: enablePrinter ?? this.enablePrinter,
      // printerIp: printerIp ?? this.printerIp,
      // printerPort: printerPort ?? this.printerPort,
    );
  }

  static Settings fromMap(dynamic map) {
    return Settings(
      // theme: ThemesOptions.values.elementAt(int.tryParse(map["theme"]) ?? 0),
      // orderSheetEnabled: map["order_sheet_enabled"],
      // enablePrinter: map["enable_printer"],
      // printerIp: map["printer_ip"],
      // printerPort: map["printer_port"],
      establishment: map["establishment"] != null
          ? Establishment.fromMap(map["establishment"])
          : Establishment.empty(),
      customization: map["customization"] != null
          ? Customization.fromMap(map["customization"])
          : Customization.empty(),
      printerSettings: map["printer_settings"] != null
          ? PrinterSettings.fromMap(map["printer_settings"])
          : PrinterSettings.empty(),
      // enableWideMode: map["enable_wide_mode"],
      // imagePath: map["image_path"],
    );
  }

  static Map<String, dynamic> toJson(Settings settings) {
    return {
      // "theme": settings.theme.index.toString(),
      // "order_sheet_enabled": settings.orderSheetEnabled,
      // "enable_printer": settings.enablePrinter,
      // "printer_ip": settings.printerIp,
      // "printer_port": settings.printerPort,
      if (settings.establishment != null)
        "establishment": Establishment.toJson(settings.establishment!),
      if (settings.printerSettings != null)
        "printer_settings": PrinterSettings.toJson(settings.printerSettings!),
      if (settings.customization != null)
        "customization": Customization.toJson(settings.customization!),
      // "enable_wide_mode": settings.enableWideMode,
      // "image_path": settings.imagePath,
    };
  }
}
