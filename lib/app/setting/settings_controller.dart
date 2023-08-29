// import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posblishment/domain/entities/entities.dart';
import 'package:posblishment/domain/enums/enums.dart';
import 'package:posblishment/domain/enums/establishment_type.dart';

class SettingsController extends Disposable {
  SettingsController();

  // final formKey = GlobalKey<FormState>();

  final establishmentNameTextController = TextEditingController();

  final establishmentType = ValueNotifier(EstablishmentType.restaurant);
  final orderSheetEnabled = ValueNotifier<bool>(false);
  final theme = ValueNotifier<ThemesOptions>(ThemesOptions.dark);

  void resetFields(Settings? settings) {
    establishmentNameTextController.text = settings?.establishment.name ?? "";
    // iconTextController.text = type?.icon ?? "";
    orderSheetEnabled.value = settings?.orderSheetEnabled ?? false;
    theme.value = settings?.theme ?? ThemesOptions.dark;
    establishmentType.value = settings?.establishment.establishmentType ??
        EstablishmentType.restaurant;
  }

  Settings updateEstablishmentName(Settings settings) {
    return settings.copyWith(
      establishment: settings.establishment
          .copyWith(name: establishmentNameTextController.text),
    );
  }

  Settings updateEstablishmentType(Settings settings) {
    return settings.copyWith(
      establishment: settings.establishment
          .copyWith(establishmentType: establishmentType.value),
    );
  }

  Settings updateOrderSheetEnabled(Settings settings) {
    return settings.copyWith(orderSheetEnabled: orderSheetEnabled.value);
  }

  Settings updateSettings(Settings settings) {
    return settings.copyWith(
      orderSheetEnabled: orderSheetEnabled.value,
      theme: theme.value,
      establishment: settings.establishment.copyWith(
        name: establishmentNameTextController.text,
        establishmentType: establishmentType.value,
      ),
    );
  }

  @override
  void dispose() {
    establishmentNameTextController.dispose();
    establishmentType.dispose();
    orderSheetEnabled.dispose();
  }
}
