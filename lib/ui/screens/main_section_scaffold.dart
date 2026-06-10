import 'package:flutter/material.dart';
import 'package:galagro/state/galagro_app_state.dart';
import 'package:galagro/ui/components/galagro_bottom_navigation.dart';
import 'package:galagro/ui/components/galagro_top_app_bar.dart';

class MainSectionScaffold extends StatelessWidget {
  final String currentRoute;
  final String title;
  final String subtitle;
  final Widget body;
  final GalagroAppState appState;
  final List<Widget>? actions;

  const MainSectionScaffold({
    super.key,
    required this.currentRoute,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.appState,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        return Scaffold(
          appBar: GalagroTopAppBar(
            title: title,
            subtitle: subtitle,
            actions: actions,
          ),
          body: body,
          bottomNavigationBar: GalagroBottomNavigation(
            currentRoute: currentRoute,
            activeAlertCount: appState.activeAlertCount,
            onNavigate: (route) {
              if (route == currentRoute) {
                return;
              }
              Navigator.pushReplacementNamed(context, route);
            },
          ),
        );
      },
    );
  }
}
