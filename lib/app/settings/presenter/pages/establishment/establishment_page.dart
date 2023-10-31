import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'establishment_controller.dart';

class EstablishmentPage extends StatefulWidget {
  const EstablishmentPage({super.key});

  @override
  State<EstablishmentPage> createState() => _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage> {
  final establishmentController = EstablishmentController();
  // final settingsStore = SettingStore();

  @override
  void initState() {
    establishmentController
      ..resetFields()
      ..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    establishmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text('Estabelecimento'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child:
              // ScopedBuilder<SettingStore, Failure, Settings>.transition(
              //   store: settingsStore,
              //   onState: (context, state) {
              Padding(
            padding: Paddings.paddingForm(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (establishmentController.image != null)
                  Stack(
                    children: [
                      Image.file(
                        establishmentController.image!,
                        width: 200,
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: ElevatedButton(
                          onPressed: establishmentController.deleteOldImage,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            minimumSize: Size.zero,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: const Icon(Icons.remove),
                        ),
                      )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextFormField(
                        decorationName: "Nome da Imagem",
                        // decoration: ,
                        enabled: false,
                        controller: establishmentController.establishmentImagePathTextController,
                        value:
                            establishmentController.parsePathToName() ?? "",
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: establishmentController.getImageFromGallery,
                        icon: const Icon(Icons.camera),
                      ),
                    ),
                  ],
                ),
                CustomTextFormField(
                  decorationName: "Nome do Estabelecimento",
                  controller:
                      establishmentController.establishmentNameTextController,
                  value: establishmentController
                      .establishmentNameTextController.text,
                ),
                CustomTextFormField(
                  decorationName: "Localização",
                  controller:
                      establishmentController.establishmentLocalTextController,
                  value: establishmentController
                      .establishmentLocalTextController.text,
                  // value: state.establishment?.name,
                ),
                CustomDropDown(
                  items: <String, String>{
                    for (var establishmentType in EstablishmentTypes.values)
                      establishmentType.index.toString(): establishmentType.name
                  },
                  value: establishmentController.establishmentType.index
                      .toString(),
                  setValue: (value) {
                    establishmentController.establishmentType =
                        EstablishmentTypes.values
                            .elementAt(int.parse(value ?? "0"));
                  },
                  labelText: "Tipo de Estabelecimento",
                ),
                ElevatedButton(
                  onPressed: establishmentController.saveChanges,
                  child: const Text("Salvar"),
                )
              ],
            ),
            //   );
            // },
          ),
        ),
      ),
    );
  }
}
