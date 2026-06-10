import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:galagro/navigation/app_navigation.dart';
import 'package:galagro/navigation/app_routes.dart';
import 'package:galagro/state/galagro_app_state.dart';
import 'package:galagro/ui/theme/app_theme.dart';

void main() {
  runApp(const GalAgroApp());
}

class GalAgroApp extends StatefulWidget {
  const GalAgroApp({super.key});

  @override
  State<GalAgroApp> createState() => _GalAgroAppState();
}

class _GalAgroAppState extends State<GalAgroApp> {
  late final GalagroAppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = GalagroAppState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GalAgro',
      theme: AppTheme.darkTheme,
      scrollBehavior: const AppScrollBehavior(),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        return AppNavigation.generateRoute(settings, _appState);
      },
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
