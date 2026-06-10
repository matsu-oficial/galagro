import 'package:flutter/material.dart';
import 'package:galagro/model/agro_region.dart';
import 'package:galagro/model/alert_item.dart';
import 'package:galagro/ui/components/metric_card.dart';
import 'package:galagro/ui/components/section_card.dart';
import 'package:galagro/ui/components/severity_badge.dart';
import 'package:galagro/ui/components/sim_note.dart';
import 'package:galagro/ui/components/status_badge.dart';
import 'package:galagro/ui/theme/app_theme.dart';
import 'package:galagro/ui/theme/responsive_layout.dart';

class DashboardScreen extends StatelessWidget {
  final List<AgroRegion> regions;
  final List<AlertItem> alerts;
  final VoidCallback onOpenRegions;
  final VoidCallback onOpenAlerts;

  const DashboardScreen({
    super.key,
    required this.regions,
    required this.alerts,
    required this.onOpenRegions,
    required this.onOpenAlerts,
  });

  @override
  Widget build(BuildContext context) {
    final totalArea = regions.fold<double>(
      0,
      (total, region) => total + region.areaInHectares,
    );
    final totalImpacted = regions.fold<int>(
      0,
      (total, region) => total + region.impactedProducers,
    );
    final featuredRisks = [...regions]
      ..sort(
        (left, right) => _severityRank(
          left.severity,
        ).compareTo(_severityRank(right.severity)),
      );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = ResponsiveLayout.boundedWidth(constraints.maxWidth);
        final compact = ResponsiveLayout.isCompact(width);
        final metricColumns = ResponsiveLayout.metricColumns(width);

        return ResponsiveContent(
          child: ListView(
            children: [
              SectionCard(
                color: const Color(0xFF0E1722),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppTheme.blue.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.public, color: AppTheme.blue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Operação',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'GalAgro',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const StatusBadge(
                          label: 'Ativo',
                          color: AppTheme.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Monitoramento agroespacial ativo',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Última leitura orbital simulada: hoje, 08:30',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cobertura: Franca e Ribeirão Preto/SP',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 14),
                    const Divider(
                      height: 1,
                      thickness: 0.6,
                      color: AppTheme.dividerSubtle,
                    ),
                    const SizedBox(height: 12),
                    const SimNote(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: metricColumns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: metricColumns == 1
                    ? 2.45
                    : metricColumns == 2
                    ? 1.05
                    : 1.45,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MetricCard(
                    icon: Icons.layers_outlined,
                    value: '${regions.length}',
                    label: 'Regiões monitoradas',
                    tone: AppTheme.blue,
                  ),
                  MetricCard(
                    icon: Icons.notifications_active_outlined,
                    value: '${alerts.length}',
                    label: 'Alertas climáticos',
                    tone: AppTheme.amber,
                  ),
                  MetricCard(
                    icon: Icons.groups_outlined,
                    value: '$totalImpacted',
                    label: 'Produtores impactados',
                    tone: AppTheme.green,
                  ),
                  MetricCard(
                    icon: Icons.grass_outlined,
                    value: totalArea.toStringAsFixed(1),
                    label: 'Hectares monitorados',
                    tone: AppTheme.green,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 8,
                spacing: 12,
                children: [
                  Text(
                    'Riscos em destaque',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SimNote(text: 'Cenário demonstrativo'),
                ],
              ),
              const SizedBox(height: 12),
              ...featuredRisks.map(
                (region) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SectionCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                region.climateRisk,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                region.name,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SeverityBadge(severity: region.severity),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              compact
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FilledButton.icon(
                          onPressed: onOpenAlerts,
                          icon: const Icon(Icons.notifications_outlined),
                          label: const Text('Ver alertas'),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: onOpenRegions,
                          icon: const Icon(Icons.layers_outlined),
                          label: const Text('Ver regiões'),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: onOpenRegions,
                            icon: const Icon(Icons.layers_outlined),
                            label: const Text('Ver regiões'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: onOpenAlerts,
                            icon: const Icon(Icons.notifications_outlined),
                            label: const Text('Ver alertas'),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  int _severityRank(String severity) {
    switch (severity) {
      case 'Crítico':
        return 0;
      case 'Alto':
        return 1;
      case 'Moderado':
        return 2;
      default:
        return 3;
    }
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
