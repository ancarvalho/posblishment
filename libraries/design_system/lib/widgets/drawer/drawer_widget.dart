import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../design_system.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  static List<PagesRoutes> routes = PagesRoutes.values
      .where((element) => element.standAlone == true)
      .toList();

  final settingsStore =
      Modular.get<AbstractSettingsStore>().state.establishment;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
           const SizedBox(
            height: 10,
          ),
          if (settingsStore != null)
            if (settingsStore!.imagePath != null)
              Image.file(File(settingsStore!.imagePath!),
              height: Sizes.height(context)*0.2,
              )
            else
              Column(
                children: [
                  Text(
                    settingsStore!.name.split(" ").first,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    settingsStore!.name.split(" ").sublist(1).join(" "),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    Modular.to.navigate(
                      "${routes[index].dependsOnModule.route}${routes[index].route}",
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    // minimumSize: Size.zero,
                    elevation: 0,
                  ),
                  child: Text(routes[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
