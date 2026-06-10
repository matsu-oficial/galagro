import 'package:flutter/material.dart';
import 'package:galagro/navigation/app_routes.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class GalagroBottomNavigation extends StatelessWidget {
  final String currentRoute;
  final int activeAlertCount;
  final ValueChanged<String> onNavigate;

  const GalagroBottomNavigation({
    super.key,
    required this.currentRoute,
    required this.activeAlertCount,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarTheme.of(context).copyWith(
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 12.5,
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: _routeToIndex(currentRoute),
        onDestinationSelected: (index) => onNavigate(_indexToRoute(index)),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Painel',
          ),
          const NavigationDestination(
            icon: Icon(Icons.layers_outlined),
            selectedIcon: Icon(Icons.layers),
            label: 'Regiões',
          ),
          NavigationDestination(
            icon: Badge.count(
              count: activeAlertCount,
              isLabelVisible: activeAlertCount > 0,
              child: const Icon(Icons.notifications_none_outlined),
            ),
            selectedIcon: Badge.count(
              count: activeAlertCount,
              isLabelVisible: activeAlertCount > 0,
              child: const Icon(Icons.notifications),
            ),
            label: 'Alertas',
          ),
        ],
      ),
    );
  }

  int _routeToIndex(String route) {
    switch (route) {
      case AppRoutes.regions:
        return 1;
      case AppRoutes.alerts:
        return 2;
      case AppRoutes.dashboard:
      default:
        return 0;
    }
  }

  String _indexToRoute(int index) {
    switch (index) {
      case 1:
        return AppRoutes.regions;
      case 2:
        return AppRoutes.alerts;
      case 0:
      default:
        return AppRoutes.dashboard;
    }
  }
}
