import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posblishment/app/settings/presenter/pages/settings/settings_controller.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final settingsController = SettingsController();
  // final settingsStore = Modular.get<SettingStore>();

  @override
  void initState() {
    settingsController

        //TODO modify later
        .addListener(() {
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
          child: Padding(
            padding: Paddings.paddingForm(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ElevatedButton(
                  onPressed: () {
                    Modular.to.pushNamed(
                      PagesRoutes.customizeSettings.dependsOnModule.route +
                          PagesRoutes.customizeSettings.route,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.format_paint),
                      SizedBox(
                        width: Sizes.dp10(context),
                      ),
                      const Text("Customização"),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Modular.to.pushNamed(
                      PagesRoutes.establishmentSettings.dependsOnModule.route +
                          PagesRoutes.establishmentSettings.route,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.home_work_outlined),
                      SizedBox(
                        width: Sizes.dp10(context),
                      ),
                      const Text("Estabelecimento"),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Modular.to.pushNamed(
                      PagesRoutes.printerSettings.dependsOnModule.route +
                          PagesRoutes.printerSettings.route,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.print_rounded),
                      SizedBox(
                        width: Sizes.dp10(context),
                      ),
                      const Text("Impressora"),
                    ],
                  ),
                ),
                // TODO put a warning that could be a slow process
                ElevatedButton(
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
                ElevatedButton(
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
                // TextButton(
                //   onPressed: () {
                //     settingsStore.saveSettings(
                //       settingsController
                //           .updateSettings(settingsStore.state),
                //     );
                //   },
                //   child: const Text("Salvar"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
