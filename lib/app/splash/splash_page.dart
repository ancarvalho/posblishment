import 'dart:async';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posblishment/app/settings/presenter/pages/settings/settings_store.dart';

import "../app_module.dart";

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // get the settings last path and push trough or home if it's null?
  Future<void> _startSplashPage() async {
    await Future.wait([
      Modular.isModuleReady<AppModule>(),
      Future.delayed(const Duration(seconds: 2)),
    ]).then((value) {
      _connectToPrinter();
      return Modular.to.navigate(PagesRoutes.statistics.dependsOnModule.route + PagesRoutes.statistics.route);
    });
  }

  void _connectToPrinter() {
    final settings = SettingStore().state;
    if(settings.printerSettings !=null && settings.printerSettings!.enablePrinter && settings.printerSettings?.printerIp != null && settings.printerSettings?.printerPort != null) {
      Modular.get<PrinterAbstract>().checkConnection(settings.printerSettings!.printerIp!, port: settings.printerSettings!.printerPort);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSplashPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Sizes.width(context) / 3,
                    width: Sizes.width(context) / 3,
                    child: Image.asset(
                      ImagesAssets.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
