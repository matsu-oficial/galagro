import 'package:flutter/material.dart';
import 'package:galagro/model/alert_item.dart';
import 'package:galagro/ui/components/alert_list_card.dart';
import 'package:galagro/ui/components/section_card.dart';
import 'package:galagro/ui/components/sim_note.dart';
import 'package:galagro/ui/theme/app_theme.dart';
import 'package:galagro/ui/theme/responsive_layout.dart';

class AlertsScreen extends StatelessWidget {
  final List<AlertItem> alerts;
  final List<AlertItem> allAlerts;
  final AlertFilter filter;
  final ValueChanged<AlertFilter> onFilterChanged;
  final ValueChanged<String> onAdvanceStatus;

  const AlertsScreen({
    super.key,
    required this.alerts,
    required this.allAlerts,
    required this.filter,
    required this.onFilterChanged,
    required this.onAdvanceStatus,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContent(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final chipFilter = AlertFilter.values[index];
                final count = _countForFilter(chipFilter, allAlerts);

                return FilterChip(
                  selected: filter == chipFilter,
                  label: Text('${chipFilter.label} ($count)'),
                  onSelected: (_) => onFilterChanged(chipFilter),
                  selectedColor: AppTheme.blue.withValues(alpha: 0.14),
                  checkmarkColor: AppTheme.blue,
                  side: const BorderSide(color: AppTheme.border),
                  labelStyle: TextStyle(
                    color: filter == chipFilter
                        ? AppTheme.blue
                        : AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemCount: AlertFilter.values.length,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
              children: [
                if (alerts.isEmpty)
                  const SectionCard(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Nenhum alerta encontrado para esse filtro.',
                        ),
                      ),
                    ),
                  )
                else
                  ...alerts.map(
                    (alert) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AlertListCard(
                        alert: alert,
                        onAdvance: () => onAdvanceStatus(alert.id),
                      ),
                    ),
                  ),
                const SizedBox(height: 6),
                const Center(
                  child: SimNote(text: 'Monitoramento climático demonstrativo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _countForFilter(AlertFilter filter, List<AlertItem> alerts) {
    switch (filter) {
      case AlertFilter.todos:
        return alerts.length;
      case AlertFilter.novo:
        return alerts.where((alert) => alert.status == AlertStatus.novo).length;
      case AlertFilter.ativo:
        return alerts
            .where((alert) => alert.status == AlertStatus.ativo)
            .length;
      case AlertFilter.resolvido:
        return alerts
            .where((alert) => alert.status == AlertStatus.resolvido)
            .length;
    }
  }
}
