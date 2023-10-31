import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:posblishment/app/settings/presenter/pages/customization/customization_controller.dart';

class CustomizationPage extends StatefulWidget {
  const CustomizationPage({super.key});

  @override
  State<CustomizationPage> createState() => _CustomizationPageState();
}

class _CustomizationPageState extends State<CustomizationPage> {
  final customizationController = CustomizationController();

  @override
  void initState() {
    customizationController
      ..resetFields()
      ..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    customizationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: const Text("Customizar"),
          centerTitle: true,
        ),
        body: Padding(
          padding: Paddings.paddingForm(),
          child: Column(
            children: [
              CustomDropDown(
                items: <String, String>{
                  for (var themeOption in ThemesOptions.values)
                    themeOption.index.toString(): themeOption.name
                },
                value: customizationController.theme.index.toString(),
                setValue: (value) {
                  customizationController.theme =
                      ThemesOptions.values.elementAt(int.parse(value ?? "0"));
                },
                labelText: "Tema",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Habilitar Comanda"),
                  Switch(
                    value: customizationController.orderSheetEnabled,
                    onChanged: (v) {
                      customizationController.orderSheetEnabled = v;
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Habilitar Wide Mode"),
                  Switch(
                    value: customizationController.enableWideMode,
                    onChanged: (v) {
                      customizationController.enableWideMode = v;
                    },
                  )
                ],
              ),
               ElevatedButton(onPressed: customizationController.saveChanges, child: const Text("Salvar"))
            ],
          ),
        ),
      ),
    );
  }
}
