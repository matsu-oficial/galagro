enum AlertStatus { novo, ativo, resolvido }

enum AlertFilter { todos, novo, ativo, resolvido }

class AlertItem {
  final String id;
  final String type;
  final String regionName;
  final String farmName;
  final String severity;
  final AlertStatus status;

  const AlertItem({
    required this.id,
    required this.type,
    required this.regionName,
    required this.farmName,
    required this.severity,
    required this.status,
  });

  AlertItem copyWith({
    String? id,
    String? type,
    String? regionName,
    String? farmName,
    String? severity,
    AlertStatus? status,
  }) {
    return AlertItem(
      id: id ?? this.id,
      type: type ?? this.type,
      regionName: regionName ?? this.regionName,
      farmName: farmName ?? this.farmName,
      severity: severity ?? this.severity,
      status: status ?? this.status,
    );
  }
}

extension AlertStatusExtension on AlertStatus {
  String get label {
    switch (this) {
      case AlertStatus.novo:
        return 'Novo';
      case AlertStatus.ativo:
        return 'Ativo';
      case AlertStatus.resolvido:
        return 'Resolvido';
    }
  }

  AlertStatus? get next {
    switch (this) {
      case AlertStatus.novo:
        return AlertStatus.ativo;
      case AlertStatus.ativo:
        return AlertStatus.resolvido;
      case AlertStatus.resolvido:
        return null;
    }
  }
}

extension AlertFilterExtension on AlertFilter {
  String get label {
    switch (this) {
      case AlertFilter.todos:
        return 'Todos';
      case AlertFilter.novo:
        return 'Novo';
      case AlertFilter.ativo:
        return 'Ativo';
      case AlertFilter.resolvido:
        return 'Resolvido';
    }
  }
}
