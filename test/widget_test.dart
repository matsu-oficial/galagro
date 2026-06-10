import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:galagro/main.dart';
import 'package:galagro/model/alert_item.dart';
import 'package:galagro/repository/agro_region_repository.dart';
import 'package:galagro/repository/alert_repository.dart';
import 'package:galagro/ui/screens/alerts_screen.dart';
import 'package:galagro/ui/screens/dashboard_screen.dart';
import 'package:galagro/ui/screens/region_detail_screen.dart';
import 'package:galagro/ui/screens/regions_screen.dart';
import 'package:galagro/ui/theme/app_theme.dart';

void main() {
  testWidgets('shows GalAgro splash screen', (tester) async {
    await tester.pumpWidget(const GalAgroApp());

    expect(find.text('Monitoramento agroespacial inteligente'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('main cards fit on a narrow mobile surface', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final regions = getAllMonitoredRegions();
    final alerts = getInitialAlerts();

    await _pumpMobile(
      tester,
      DashboardScreen(
        regions: regions,
        alerts: alerts,
        onOpenRegions: () {},
        onOpenAlerts: () {},
      ),
    );
    expect(tester.takeException(), isNull);

    await _pumpMobile(
      tester,
      RegionsScreen(regions: regions, onOpenRegion: (_) {}),
    );
    expect(tester.takeException(), isNull);

    await _pumpMobile(
      tester,
      AlertsScreen(
        alerts: alerts,
        allAlerts: alerts,
        filter: AlertFilter.todos,
        onFilterChanged: (_) {},
        onAdvanceStatus: (_) {},
      ),
    );
    expect(tester.takeException(), isNull);

    await _pumpMobile(
      tester,
      RegionDetailScreen(
        region: regions.first,
        alertAlreadyEmitted: false,
        onAlertEmitted: () {},
      ),
    );
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpMobile(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Scaffold(body: child),
    ),
  );
  await tester.pumpAndSettle();
}
