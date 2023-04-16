import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'setting/setting_store.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SettingStore();
    
    return ScopedBuilder<SettingStore, Failure, bool>(
      store: store,
      onState: (context, state) {
        return MaterialApp.router(
          title: AppConstant.appName,
          theme:  Themes.lightTheme,
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        );
      },
    );
  }
}
