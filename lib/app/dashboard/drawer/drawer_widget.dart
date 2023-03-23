import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum Pages {
  dashboard(name: "Dashboard", route: "/dashboard/statistics/"),
  managementProducts(name: "Management Products", route: "/dashboard/management/all_products"),
  managementCategories(name: "Management Categories", route: "/dashboard/management/all_categories");

  const Pages({required this.name, required this.route});

  final String name;
  final String route;
}

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
          primaryColor: Theme.of(context).colorScheme.secondary,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(bodySmall: TextStyle(color: ColorPalettes.setActive)),
        ),
        child: Column(
          children: [
            ...Pages.values.map(
              (e) => TextButton(
                onPressed: () {
                  Modular.to.navigate(e.route);
                  Navigator.of(context).pop();
                },
                child: Text(e.name),
              ),
            )
          ],
        ),
      ),
    );
  }
}