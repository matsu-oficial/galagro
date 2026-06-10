import 'package:flutter/foundation.dart';
import 'package:galagro/model/agro_region.dart';
import 'package:galagro/model/alert_item.dart';
import 'package:galagro/repository/agro_region_repository.dart';
import 'package:galagro/repository/alert_repository.dart';

class GalagroAppState extends ChangeNotifier {
  GalagroAppState()
    : _regions = getAllMonitoredRegions(),
      _alerts = getInitialAlerts();

  final List<AgroRegion> _regions;
  List<AlertItem> _alerts;
  final Set<String> _emittedRegionIds = <String>{};
  AlertFilter _filter = AlertFilter.todos;

  List<AgroRegion> get regions => List.unmodifiable(_regions);
  List<AlertItem> get alerts => List.unmodifiable(_alerts);
  AlertFilter get filter => _filter;
  int get activeAlertCount => getActiveAlertCount(_alerts);
  List<AlertItem> get filteredAlerts => filterAlerts(_alerts, _filter);

  bool isAlertEmittedForRegion(String regionId) {
    return _emittedRegionIds.contains(regionId);
  }

  void setFilter(AlertFilter filter) {
    if (_filter == filter) {
      return;
    }
    _filter = filter;
    notifyListeners();
  }

  void advanceAlert(String alertId) {
    _alerts = advanceAlertStatus(_alerts, alertId);
    notifyListeners();
  }

  void markRegionAlertEmitted(String regionId) {
    if (_emittedRegionIds.add(regionId)) {
      notifyListeners();
    }
  }
}
