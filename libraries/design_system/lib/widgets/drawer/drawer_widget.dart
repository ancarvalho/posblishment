import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
static  List<PagesRoutes> routes = PagesRoutes.values.where((element) => element.standAlone == true).toList();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return TextButton(
                      onPressed: () {
                        Modular.to.navigate("${routes[index].dependsOnModule.route}${routes[index].route}");
                        Navigator.of(context).pop();
                      },
                      child: Text(routes[index].name),
                    );
        },
       
      ),
    );
  }
}
