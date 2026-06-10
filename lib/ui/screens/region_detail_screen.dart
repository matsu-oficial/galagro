import 'package:flutter/material.dart';
import 'package:galagro/model/agro_region.dart';
import 'package:galagro/ui/components/galagro_top_app_bar.dart';
import 'package:galagro/ui/components/indicator_card.dart';
import 'package:galagro/ui/components/section_card.dart';
import 'package:galagro/ui/components/severity_badge.dart';
import 'package:galagro/ui/components/sim_note.dart';
import 'package:galagro/ui/components/status_badge.dart';
import 'package:galagro/ui/theme/app_theme.dart';
import 'package:galagro/ui/theme/responsive_layout.dart';

class RegionDetailArguments {
  final AgroRegion region;
  final bool alertAlreadyEmitted;
  final VoidCallback onAlertEmitted;

  const RegionDetailArguments({
    required this.region,
    required this.alertAlreadyEmitted,
    required this.onAlertEmitted,
  });
}

class RegionDetailScreen extends StatefulWidget {
  final AgroRegion region;
  final bool alertAlreadyEmitted;
  final VoidCallback onAlertEmitted;

  const RegionDetailScreen({
    super.key,
    required this.region,
    required this.alertAlreadyEmitted,
    required this.onAlertEmitted,
  });

  @override
  State<RegionDetailScreen> createState() => _RegionDetailScreenState();
}

class _RegionDetailScreenState extends State<RegionDetailScreen> {
  late bool _alertEmitted;

  @override
  void initState() {
    super.initState();
    _alertEmitted = widget.alertAlreadyEmitted;
  }

  @override
  Widget build(BuildContext context) {
    final region = widget.region;

    return Scaffold(
      appBar: const GalagroTopAppBar(
        title: 'Detalhe da lavoura',
        subtitle:
            'Leitura orbital demonstrativa da região agrícola selecionada.',
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = ResponsiveLayout.boundedWidth(constraints.maxWidth);
          final indicatorColumns = ResponsiveLayout.indicatorColumns(width);

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
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _riskColor(
                                region.climateRisk,
                              ).withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(14),
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
                                  region.farmName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${region.name} - ${region.city}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          SeverityBadge(severity: region.severity),
                          StatusBadge(label: region.regionStatus),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  child: Column(
                    children: [
                      _DataRow(label: 'Região', value: region.name),
                      _DataRow(label: 'Município', value: region.city),
                      _DataRow(label: 'Produtor', value: region.producerName),
                      _DataRow(label: 'Cultura', value: region.cropName),
                      _DataRow(label: 'Área', value: region.formattedArea),
                      _DataRow(
                        label: 'Risco climático',
                        value: region.climateRisk,
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 8,
                  spacing: 12,
                  children: [
                    Text(
                      'Leitura climática',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SimNote(text: 'Leitura orbital demonstrativa'),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: indicatorColumns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: indicatorColumns == 1
                      ? 3.6
                      : indicatorColumns == 2
                      ? 1.3
                      : 1.9,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    IndicatorCard(
                      icon: Icons.water_drop_outlined,
                      label: 'Umidade do solo estimada',
                      value: '${region.soilHumidityPercent}%',
                      tone: AppTheme.blue,
                      progress: region.soilHumidityPercent / 100,
                    ),
                    IndicatorCard(
                      icon: Icons.show_chart_rounded,
                      label: 'Índice de vegetação orbital',
                      value: region.formattedNdvi,
                      tone: AppTheme.green,
                      progress: region.ndvi,
                    ),
                    IndicatorCard(
                      icon: Icons.grain_outlined,
                      label: 'Precipitação estimada',
                      value: region.formattedRainfall,
                      tone: AppTheme.blue,
                    ),
                    IndicatorCard(
                      icon: Icons.device_thermostat_outlined,
                      label: 'Temperatura estimada',
                      value: region.formattedTemperature,
                      tone: AppTheme.amber,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SectionCard(
                  child: Row(
                    children: [
                      const Icon(Icons.schedule, color: AppTheme.amber),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Janela de risco',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              region.riskWindow,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Impactados',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${region.impactedProducers} produtores',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _RecommendationCard(
                  title: 'Recomendação pública',
                  icon: Icons.shield_outlined,
                  tone: AppTheme.blue,
                  body: region.publicRecommendation,
                ),
                const SizedBox(height: 12),
                _RecommendationCard(
                  title: 'Orientação ao produtor',
                  icon: Icons.eco_outlined,
                  tone: AppTheme.green,
                  body: region.producerGuidance,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = ResponsiveLayout.isCompact(constraints.maxWidth);

            return compact
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton.icon(
                        onPressed: _alertEmitted ? null : _emitAlert,
                        icon: Icon(
                          _alertEmitted ? Icons.check : Icons.send_outlined,
                        ),
                        label: Text(
                          _alertEmitted ? 'Alerta emitido' : 'Emitir alerta',
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Voltar'),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Voltar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _alertEmitted ? null : _emitAlert,
                          icon: Icon(
                            _alertEmitted ? Icons.check : Icons.send_outlined,
                          ),
                          label: Text(
                            _alertEmitted ? 'Alerta emitido' : 'Emitir alerta',
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  void _emitAlert() {
    setState(() {
      _alertEmitted = true;
    });
    widget.onAlertEmitted();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alerta da região registrado com sucesso.')),
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

class _DataRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const _DataRow({
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 12),
          const Divider(
            height: 1,
            thickness: 0.6,
            color: AppTheme.dividerSubtle,
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color tone;
  final String body;

  const _RecommendationCard({
    required this.title,
    required this.icon,
    required this.tone,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: tone, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(body, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
