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
  static final routes = genModulatedRoutes();

  final settingsStore =
      Modular.get<AbstractSettingsStore>().state.establishment;

  final b = debugPrint("redraw");

  List<String>? splitName() {
    if (settingsStore != null) {
      final name = settingsStore!.name.split(" ");
      final first = name.first;
      final rest = name.sublist(1).join(" ");
      return [first, rest];
    }
    return null;
  }

  double calculateFontSize(String text) {
    final width = Sizes.isMobile(context)
        ? Sizes.width(context) * .6
        : Sizes.width(context) * .36;
    final fontSize = width / (text.length / 1.35);
    // debugPrint(fontSize.toString());
    return fontSize;
  }

  @override
  Widget build(BuildContext context) {
    final titleAndSubtitle = splitName();
    return Drawer(
      width: Sizes.isMobile(context)
          ? Sizes.width(context) * .6
          : Sizes.width(context) * .36,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            if (settingsStore != null)
              DrawerHeader(
                child: settingsStore!.imagePath != null
                    ? Image.file(
                        File(settingsStore!.imagePath!),
                        height: Sizes.height(context) * 0.2,
                      )
                    : Center(
                        child: Column(
                          children: [
                            Text(
                              titleAndSubtitle!.first,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: calculateFontSize(
                                        titleAndSubtitle.first),
                                  ),
                            ),
                            if (titleAndSubtitle.last != "")
                              Text(
                                titleAndSubtitle.last,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      fontSize: calculateFontSize(
                                        titleAndSubtitle.last,
                                      ),
                                    ),
                              ),
                            const SizedBox(height: 4,),  
                            Text(settingsStore!.location ?? "",
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
              ),
            // if (settingsStore != null)
            //   if (settingsStore!.imagePath != null)
            //     Image.file(
            //       File(settingsStore!.imagePath!),
            //       height: Sizes.height(context) * 0.2,
            //     )
            //   else
            //     Center(
            //       child: Column(
            //         children: [
            //           Text(
            //             titleAndSubtitle!.first,
            //             style:
            //                 Theme.of(context).textTheme.displayMedium?.copyWith(
            //                       fontSize:
            //                           calculateFontSize(titleAndSubtitle.first),
            //                     ),
            //           ),
            //           Text(titleAndSubtitle.last,
            //               style: Theme.of(context).textTheme.displaySmall),
            //         ],
            //       ),
            //     ),
            const SizedBox(
              height: 20,
            ),
            for (final r in routes.entries)
              if (r.value.length < 2)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      Modular.to.navigate(
                        "${r.value[0].dependsOnModule.route}${r.value[0].route}",
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(r.value[0].name),
                  ),
                )
              else
                ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  expandedAlignment: Alignment.centerLeft,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text(r.key.name),
                  children: [
                    for (final i in r.value)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextButton(
                          onPressed: () {
                            Modular.to.navigate(
                              "${i.dependsOnModule.route}${i.route}",
                            );
                            Navigator.of(context).pop();
                          },
                          child: Text(i.name),
                        ),
                      )
                  ],
                ),
                
          ],
        ),
      ),
    );
  }
}
