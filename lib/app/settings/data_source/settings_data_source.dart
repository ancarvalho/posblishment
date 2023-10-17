import 'package:core/core.dart';
import "package:drift/drift.dart";
import 'package:internal_database/internal_database.dart';
import 'package:posblishment/app/settings/domain/entities/establishment_settings.dart';
import 'package:posblishment/app/settings/domain/errors/settings_failures.dart';

class SettingsDataSource {
  final AppDatabase _appDatabase;

  SettingsDataSource(this._appDatabase);

  Future<bool> checkIfSettingsExist() async {
    try {
    final count = await _appDatabase.customSelect("""
      SELECT COUNT(*) as count
      FROM establishment_settings
      GROUP BY id
      """).getSingle().then((r) => r.read<int>("count"));

    return count > 0;
     } catch (e, s) {
      throw SettingsError(
        s,
        "EstablishmentSettings-checkIfSettingsExist",
        e,
        e.toString(),
      );
    }
  }

  Future<EstablishmentSettings> getSettings() async {
    try {
      final settings = await _appDatabase.customSelect("""
        SELECT *
        FROM establishment_settings
        LIMIT 1
      """).getSingle().then(
            (r) => EstablishmentSettings(
              id: r.read<String>("id"),
              name: r.read<String>("name"),
              description: r.read<String?>("description"),
              establishmentType: EstablishmentTypes.values
                  .elementAt(r.read<int>("establishmentType")),
              address: r.read<String?>("address"),
              imageSrc: r.read<String?>("imageSrc"),
              enableOrderSheet: r.read<bool>("enableOrderSheet"),
              enableWideViewMode: r.read<bool>("enableWideViewMode"),
              printerEnabled: r.read<bool>("printerEnabled"),
              printerIp: r.read<String?>("printerIp"),
              printerPort: r.read<int>("printerPort"),
              theme: ThemesOptions.values.elementAt(r.read<int>("theme")),
              createdAt: r.read<DateTime>("createdAt"),
              updatedAt: r.read<DateTime?>("updatedAt"),
            ),
          );
      return settings;
    } catch (e, s) {
      throw SettingsError(
        s,
        "EstablishmentSettings-getEstablishment",
        e,
        e.toString(),
      );
    }
  }

  Future<int> createEstablishment(
    NewEstablishmentSettings newEstablishmentSettings,
  ) async {
    try {
      final txId = await _appDatabase.customInsert(
        """
        INSERT INTO establishment_settings (name, description, establishment_type, address, image_src, enable_order_sheet, enable_wide_view_mode, printer_enabled, printer_ip, printer_port, theme )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      """,
        variables: [
          Variable(newEstablishmentSettings.name),
          Variable(newEstablishmentSettings.description),
          Variable(newEstablishmentSettings.establishmentType),
          Variable(newEstablishmentSettings.address),
          Variable(newEstablishmentSettings.imageSrc),
          Variable(newEstablishmentSettings.enableOrderSheet),
          Variable(newEstablishmentSettings.enableWideViewMode),
          Variable(newEstablishmentSettings.printerEnabled),
          Variable(newEstablishmentSettings.printerIp),
          Variable(newEstablishmentSettings.printerPort),
          Variable(newEstablishmentSettings.theme),
        ],
        updates: {_appDatabase.establishmentSettings},
      );
      return txId;
    } catch (e, s) {
      throw SettingsError(
        s,
        "EstablishmentSettings-createEstablishment",
        e,
        e.toString(),
      );
    }
  }

  Future<int> updateEstablishmentSettings(
    NewEstablishmentSettings newEstablishmentSettings,
  ) async {
    try {
      final txId = await _appDatabase.customInsert(
        """
        UPDATE establishment_settings
        SET 
          name = COALESCE(name, ?)
          description = COALESCE(description, ?)
          establishmentType = COALESCE(establishmentType, ?)
          address = COALESCE(address, ?)
          imageSrc = COALESCE(imageSrc, ?)
          enableOrderSheet = COALESCE(enableOrderSheet, ?)
          enableWideViewMode = COALESCE(enableWideViewMode, ?)
          printerEnabled = COALESCE(printerEnabled, ?)
          printerIp = COALESCE(printerIp, ?)
          printerPort = COALESCE(printerPort, ?)
          theme = COALESCE(theme, ?)

      """,
        variables: [
          Variable(newEstablishmentSettings.name),
          Variable(newEstablishmentSettings.description),
          Variable(newEstablishmentSettings.establishmentType),
          Variable(newEstablishmentSettings.address),
          Variable(newEstablishmentSettings.imageSrc),
          Variable(newEstablishmentSettings.enableOrderSheet),
          Variable(newEstablishmentSettings.enableWideViewMode),
          Variable(newEstablishmentSettings.printerEnabled),
          Variable(newEstablishmentSettings.printerIp),
          Variable(newEstablishmentSettings.printerPort),
          Variable(newEstablishmentSettings.theme),
        ],
        updates: {_appDatabase.establishmentSettings},
      );
      return txId;
    } catch (e, s) {
      throw SettingsError(
        s,
        "EstablishmentSettings-createEstablishment",
        e,
        e.toString(),
      );
    }
  }
}
