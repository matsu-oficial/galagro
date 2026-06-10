import 'package:flutter/material.dart';
import 'package:galagro/navigation/app_routes.dart';
import 'package:galagro/state/galagro_app_state.dart';
import 'package:galagro/ui/screens/alerts_screen.dart';
import 'package:galagro/ui/screens/dashboard_screen.dart';
import 'package:galagro/ui/screens/intro_screen.dart';
import 'package:galagro/ui/screens/main_section_scaffold.dart';
import 'package:galagro/ui/screens/region_detail_screen.dart';
import 'package:galagro/ui/screens/regions_screen.dart';
import 'package:galagro/ui/screens/splash_screen.dart';

class AppNavigation {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
    GalagroAppState appState,
  ) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            onFinished: () {
              Navigator.pushReplacementNamed(context, AppRoutes.intro);
            },
          ),
        );
      case AppRoutes.intro:
        return MaterialPageRoute(
          builder: (context) => IntroScreen(
            onBack: () {
              Navigator.pushReplacementNamed(context, AppRoutes.splash);
            },
            onEnter: () {
              Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
            },
          ),
        );
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (context) => AnimatedBuilder(
            animation: appState,
            builder: (_, _) {
              return MainSectionScaffold(
                currentRoute: AppRoutes.dashboard,
                title: 'Painel agroespacial',
                subtitle:
                    'Acompanhamento climático demonstrativo de regiões agrícolas.',
                appState: appState,
                body: DashboardScreen(
                  regions: appState.regions,
                  alerts: appState.alerts,
                  onOpenRegions: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.regions);
                  },
                  onOpenAlerts: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.alerts);
                  },
                ),
              );
            },
          ),
        );
      case AppRoutes.regions:
        return MaterialPageRoute(
          builder: (context) => AnimatedBuilder(
            animation: appState,
            builder: (_, _) {
              return MainSectionScaffold(
                currentRoute: AppRoutes.regions,
                title: 'Regiões monitoradas',
                subtitle:
                    'Áreas agrícolas acompanhadas no cenário demonstrativo.',
                appState: appState,
                body: RegionsScreen(
                  regions: appState.regions,
                  onOpenRegion: (region) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.regionDetail,
                      arguments: RegionDetailArguments(
                        region: region,
                        alertAlreadyEmitted: appState.isAlertEmittedForRegion(
                          region.id,
                        ),
                        onAlertEmitted: () {
                          appState.markRegionAlertEmitted(region.id);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      case AppRoutes.alerts:
        return MaterialPageRoute(
          builder: (context) => AnimatedBuilder(
            animation: appState,
            builder: (_, _) {
              return MainSectionScaffold(
                currentRoute: AppRoutes.alerts,
                title: 'Alertas climáticos',
                subtitle:
                    'Ocorrências registradas para as regiões acompanhadas.',
                appState: appState,
                body: AlertsScreen(
                  alerts: appState.filteredAlerts,
                  allAlerts: appState.alerts,
                  filter: appState.filter,
                  onFilterChanged: appState.setFilter,
                  onAdvanceStatus: appState.advanceAlert,
                ),
              );
            },
          ),
        );
      case AppRoutes.regionDetail:
        final args = settings.arguments as RegionDetailArguments?;
        if (args == null) {
          return _notFoundRoute();
        }
        return MaterialPageRoute(
          builder: (_) => RegionDetailScreen(
            region: args.region,
            alertAlreadyEmitted: args.alertAlreadyEmitted,
            onAlertEmitted: args.onAlertEmitted,
          ),
        );
      default:
        return _notFoundRoute();
    }
  }

  static MaterialPageRoute<dynamic> _notFoundRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Rota não encontrada'))),
    );
  }
}
