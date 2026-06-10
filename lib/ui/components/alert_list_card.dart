import 'package:flutter/material.dart';
import 'package:galagro/model/alert_item.dart';
import 'package:galagro/ui/components/section_card.dart';
import 'package:galagro/ui/components/severity_badge.dart';
import 'package:galagro/ui/components/status_badge.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class AlertListCard extends StatelessWidget {
  final AlertItem alert;
  final VoidCallback? onAdvance;

  const AlertListCard({super.key, required this.alert, this.onAdvance});

  @override
  Widget build(BuildContext context) {
    final resolved = alert.status == AlertStatus.resolvido;

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _riskColor(alert.type).withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _riskIcon(alert.type),
                    color: _riskColor(alert.type),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.type,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      alert.regionName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      alert.farmName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SeverityBadge(severity: alert.severity),
            ],
          ),
          const SizedBox(height: 13),
          const Divider(
            height: 1,
            thickness: 0.6,
            color: AppTheme.dividerSubtle,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: StatusBadge(label: alert.status.label),
                ),
              ),
              const SizedBox(width: 12),
              if (resolved)
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: AppTheme.green,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Concluído',
                      style: TextStyle(
                        color: AppTheme.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              else
                FilledButton.tonalIcon(
                  onPressed: onAdvance,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.green,
                    foregroundColor: const Color(0xFF04140A),
                    minimumSize: const Size(132, 44),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                  ),
                  icon: Icon(
                    alert.status == AlertStatus.novo
                        ? Icons.power_settings_new
                        : Icons.check,
                    size: 18,
                  ),
                  label: Text(
                    alert.status == AlertStatus.novo ? 'Ativar' : 'Resolver',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _riskIcon(String risk) {
    switch (risk) {
      case 'Seca':
        return Icons.wb_sunny_outlined;
      case 'Calor extremo':
        return Icons.device_thermostat_outlined;
      default:
        return Icons.grain_outlined;
    }
  }

  Color _riskColor(String risk) {
    switch (risk) {
      case 'Seca':
        return AppTheme.amber;
      case 'Calor extremo':
        return AppTheme.red;
      default:
        return AppTheme.blue;
    }
  }
}
