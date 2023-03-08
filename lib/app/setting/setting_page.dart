import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'setting_store.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.dp10(context)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Theme'),
              leading: const Icon(Icons.theater_comedy),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Sizes.dp16(context),
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return ScopedBuilder<SettingStore, Failure, bool>.transition(
                    store: SettingStore(),
                    onLoading: (context) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    onState: (context, state) => CustomDialog(
                      groupValue: state,
                      isDark: false,
                      onChanged: (value) {
                        SettingStore().changeTheme(isDark: value);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
