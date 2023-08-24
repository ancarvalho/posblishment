import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ...PagesRoutes.values.map(
            (e) => TextButton(
              onPressed: () {
                Modular.to.navigate("${e.dependsOnModule.route}${e.route}");
                Navigator.of(context).pop();
              },
              child: Text(e.name),
            ),
          )
        ],
      ),
    );
  }
}
