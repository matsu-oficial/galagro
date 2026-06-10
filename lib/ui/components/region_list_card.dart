import 'package:flutter/material.dart';
import 'package:galagro/model/agro_region.dart';
import 'package:galagro/ui/components/section_card.dart';
import 'package:galagro/ui/components/severity_badge.dart';
import 'package:galagro/ui/components/status_badge.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class RegionListCard extends StatelessWidget {
  final AgroRegion region;
  final ValueChanged<AgroRegion> onTap;

  const RegionListCard({super.key, required this.region, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(region),
      borderRadius: BorderRadius.circular(22),
      child: SectionCard(
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
                      color: _riskColor(
                        region.climateRisk,
                      ).withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _riskIcon(region.climateRisk),
                      color: _riskColor(region.climateRisk),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        region.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        region.farmName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SeverityBadge(severity: region.severity),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(
              height: 1,
              thickness: 0.6,
              color: AppTheme.dividerSubtle,
            ),
            const SizedBox(height: 14),
            Wrap(
              runSpacing: 10,
              spacing: 16,
              children: [
                _InfoColumn(label: 'Município', value: region.city),
                _InfoColumn(label: 'Cultura', value: region.cropName),
                _InfoColumn(label: 'Risco', value: region.climateRisk),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: StatusBadge(label: region.regionStatus),
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ver detalhes',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.chevron_right,
                      color: AppTheme.blue,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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

class _InfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const _InfoColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textMuted,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
