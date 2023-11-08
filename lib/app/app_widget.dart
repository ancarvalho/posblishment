import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:posblishment/domain/utils/get_theme.dart';
import 'settings/presenter/pages/settings/settings_store.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SettingStore();
    
    return ScopedBuilder<SettingStore, Failure, Settings>(
      store: store,
      onState: (context, state) {
        return MaterialApp.router(
          title: AppConstant.appName,
          theme:  getTheme(state.customization?.theme),
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        );
      },
    );
  }
}
