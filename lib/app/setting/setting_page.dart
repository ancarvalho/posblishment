import 'package:core/core.dart';
import 'package:design_system/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:posblishment/app/setting/settings_controller.dart';
import 'package:posblishment/domain/entities/entities.dart';
import 'package:posblishment/domain/enums/enums.dart';

import 'setting_store.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final settingsController = SettingsController();
  final settingsStore = SettingStore();

  @override
  void initState() {
    settingsController.resetFields(settingsStore.state);
    //TODO modify later
    settingsController.orderSheetEnabled.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ScopedBuilder<SettingStore, Failure, Settings>.transition(
        store: settingsStore,
        onState: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  decorationName: "Nome do Estabelecimento",
                  controller:
                      settingsController.establishmentNameTextController,
                  value: state.establishment.name,
                ),
                CustomDropDown(
                  items: <String, String>{
                    for (var establishmentType in EstablishmentType.values)
                      establishmentType.index.toString(): establishmentType.name
                  },
                  value: settingsController.establishmentType.value.index
                      .toString(),
                  setValue: (value) {
                    settingsController.establishmentType.value =
                        EstablishmentType.values
                            .elementAt(int.parse(value ?? "0"));
                  },
                  labelText: "Tipo de Estabelecimento",
                ),
                CustomDropDown(
                  items: <String, String>{
                    for (var themeOption in ThemesOptions.values)
                      themeOption.index.toString(): themeOption.name
                  },
                  value: settingsController.theme.value.index.toString(),
                  setValue: (value) {
                    settingsController.theme.value =
                        ThemesOptions.values.elementAt(int.parse(value ?? "0"));
                    settingsStore.changeTheme(
                        theme: ThemesOptions.values
                            .elementAt(int.parse(value ?? "0")),);
                  },
                  labelText: "Tema",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Habilitar Comanda"),
                    Switch(
                        value: settingsController.orderSheetEnabled.value,
                        onChanged: (v) {
                          settingsController.orderSheetEnabled.value = v;
                        },)
                  ],
                ),
              // TODO put a warning that could be a slow process
               TextButton(
                    onPressed: settingsController.backupDatabase,
                    child: const Text("Backup"),),

                TextButton(
                    onPressed: () {
                      settingsStore.saveSettings(
                        settingsController.updateSettings(settingsStore.state),
                      );
                    },
                    child: const Text("Salvar"),),
              ],
            ),
          );
        },
      ),
    );
  }
}
