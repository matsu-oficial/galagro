import 'package:galagro/model/alert_item.dart';

List<AlertItem> getInitialAlerts() {
  return const [
    AlertItem(
      id: 'a1',
      type: 'Chuva intensa',
      regionName: 'Cinturão Cafeeiro',
      farmName: 'Fazenda Boa Vista',
      severity: 'Crítico',
      status: AlertStatus.ativo,
    ),
    AlertItem(
      id: 'a2',
      type: 'Calor extremo',
      regionName: 'Zona Rural Norte',
      farmName: 'Sítio Santa Helena',
      severity: 'Alto',
      status: AlertStatus.novo,
    ),
    AlertItem(
      id: 'a3',
      type: 'Seca',
      regionName: 'Área Agrícola Sul',
      farmName: 'Fazenda Três Ipês',
      severity: 'Moderado',
      status: AlertStatus.resolvido,
    ),
  ];
}

int getActiveAlertCount(List<AlertItem> alerts) {
  return alerts.where((alert) => alert.status != AlertStatus.resolvido).length;
}

List<AlertItem> advanceAlertStatus(List<AlertItem> alerts, String alertId) {
  return alerts.map((alert) {
    if (alert.id != alertId || alert.status.next == null) {
      return alert;
    }

    return alert.copyWith(status: alert.status.next);
  }).toList();
}

List<AlertItem> filterAlerts(List<AlertItem> alerts, AlertFilter filter) {
  switch (filter) {
    case AlertFilter.todos:
      return alerts;
    case AlertFilter.novo:
      return alerts.where((alert) => alert.status == AlertStatus.novo).toList();
    case AlertFilter.ativo:
      return alerts
          .where((alert) => alert.status == AlertStatus.ativo)
          .toList();
    case AlertFilter.resolvido:
      return alerts
          .where((alert) => alert.status == AlertStatus.resolvido)
          .toList();
  }
}
