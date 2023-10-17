import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:posblishment/app/settings/presenter/pages/settings/settings_controller.dart';
import 'package:posblishment/domain/entities/entities.dart';
import 'settings_store.dart';

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
    settingsController..resetFields(settingsStore.state)
    //TODO modify later
    ..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: ScopedBuilder<SettingStore, Failure, Settings>.transition(
            store: settingsStore,
            onState: (context, state) {
              return Padding(
                padding: Paddings.paddingForm(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      decorationName: "Nome do Estabelecimento",
                      controller:
                          settingsController.establishmentNameTextController,
                      value: state.establishment?.name,
                    ),
                    CustomDropDown(
                      items: <String, String>{
                        for (var establishmentType in EstablishmentTypes.values)
                          establishmentType.index.toString():
                              establishmentType.name
                      },
                      value: settingsController.establishmentType.index
                          .toString(),
                      setValue: (value) {
                        settingsController.establishmentType =
                            EstablishmentTypes.values
                                .elementAt(int.parse(value ?? "0"));
                      },
                      labelText: "Tipo de Estabelecimento",
                    ),
                    CustomDropDown(
                      items: <String, String>{
                        for (var themeOption in ThemesOptions.values)
                          themeOption.index.toString(): themeOption.name
                      },
                      value: settingsController.theme.index.toString(),
                      setValue: (value) {
                        settingsController.theme = ThemesOptions.values
                            .elementAt(int.parse(value ?? "0"));
                        settingsStore.changeTheme(
                          theme: ThemesOptions.values
                              .elementAt(int.parse(value ?? "0")),
                        );
                      },
                      labelText: "Tema",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Habilitar Comanda"),
                        Switch(
                          value: settingsController.orderSheetEnabled,
                          onChanged: (v) {
                            settingsController.orderSheetEnabled = v;
                          },
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Habilitar Impressora  "),
                        Switch(
                          value: settingsController.enablePrinter,
                          onChanged: (v) {
                            settingsController.enablePrinter = v;
                          },
                        )
                      ],
                    ),

                    if (settingsController.enablePrinter)
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: CustomTextFormField(
                              decorationName: "Ip da impressora",
                              controller:
                                  settingsController.printerIpTextController,
                              keyboardType: TextInputType.number,
                              value: settingsController
                                  .printerIpTextController.text,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CustomTextFormField(
                              decorationName: "Porta",
                              controller:
                                  settingsController.printerPortTextController,
                              value: settingsController
                                  .printerPortTextController.text,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      ),

                    // TODO put a warning that could be a slow process
                    TextButton(
                      onPressed: () async {
                        displayMessageOnSnackbar(
                          context,
                          "Iniciando Backup",
                          duration: 1,
                        );
                        await settingsController.backupDatabase().then(
                              (value) => displayMessageOnSnackbar(
                                context,
                                "Backup Finalizado",
                              ),
                            );
                      },
                      child: const Text("Backup"),
                    ),
                    TextButton(
                      onPressed: () async {
                        displayMessageOnSnackbar(
                          context,
                          "Iniciando Restore",
                          duration: 1,
                        );
                        await settingsController.restoreDatabase().then(
                              (value) => displayMessageOnSnackbar(
                                context,
                                "Restore Finalizado e necessário reiniciar o APP",
                              ),
                            );
                      },
                      child: const Text("Restore Database"),
                    ),
                    TextButton(
                      onPressed: () {
                        settingsStore.saveSettings(
                          settingsController
                              .updateSettings(settingsStore.state),
                        );
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
