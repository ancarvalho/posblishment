import 'package:core/core.dart';

// import 'current_route.dart';

class Customization {
  final ThemesOptions theme;
  final bool orderSheetEnabled;
  final bool enableWideMode;

  const Customization({
    this.theme = ThemesOptions.dark,
    this.orderSheetEnabled = false,
    this.enableWideMode = false,

  });

  factory Customization.empty() {
    return const Customization();
  }

  Customization copyWith({
    ThemesOptions? theme,
    bool? orderSheetEnabled,
    bool? enableWideMode,

  }) {
    return Customization(
      theme: theme ?? this.theme,
      orderSheetEnabled: orderSheetEnabled ?? this.orderSheetEnabled,
      enableWideMode: enableWideMode ?? this.enableWideMode,

    );
  }

  static Customization fromMap(dynamic map) {
    return Customization(
        theme: ThemesOptions.values.elementAt(int.tryParse(map["theme"]) ?? 0),
        orderSheetEnabled: map["order_sheet_enabled"],
        enableWideMode: map["enable_wide_mode"],
        );
  }

  static Map<String, dynamic> toJson(Customization customization) {
    return {
      "theme": customization.theme.index.toString(),
      "order_sheet_enabled": customization.orderSheetEnabled,
      "enable_wide_mode": customization.enableWideMode,

    };
  }
}
