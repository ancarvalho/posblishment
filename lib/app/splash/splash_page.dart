import 'dart:async';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import "../app_module.dart";


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  Future<void> _startSplashPage() async {
    await Future.wait([
      Modular.isModuleReady<AppModule>(),
      Future.delayed(const Duration(seconds: 2)),
    ]).then(
      (value) => Modular.to.navigate('/home'),
    );
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
