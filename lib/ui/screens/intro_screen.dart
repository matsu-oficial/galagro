import 'package:flutter/material.dart';
import 'package:galagro/ui/components/section_card.dart';
import 'package:galagro/ui/components/sim_note.dart';
import 'package:galagro/ui/theme/app_theme.dart';
import 'package:galagro/ui/theme/responsive_layout.dart';

class IntroScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onEnter;

  const IntroScreen({super.key, required this.onBack, required this.onEnter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = ResponsiveLayout.boundedWidth(constraints.maxWidth);
            final compact = ResponsiveLayout.isCompact(width);
            final wide = ResponsiveLayout.isDesktop(width);

            return Column(
              children: [
                Expanded(
                  child: ResponsiveContent(
                    padding: EdgeInsets.fromLTRB(
                      compact ? 20 : 24,
                      28,
                      compact ? 20 : 24,
                      20,
                    ),
                    child: ListView(
                      children: [
                        if (wide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(flex: 5, child: _IntroHero()),
                              const SizedBox(width: 20),
                              const Expanded(flex: 6, child: _FeatureList()),
                            ],
                          )
                        else ...[
                          const _IntroHero(),
                          const SizedBox(height: 24),
                          const _FeatureList(),
                        ],
                        const SizedBox(height: 22),
                        const SimNote(),
                      ],
                    ),
                  ),
                ),
                ResponsiveContent(
                  padding: EdgeInsets.fromLTRB(
                    compact ? 20 : 24,
                    12,
                    compact ? 20 : 24,
                    26,
                  ),
                  child: compact
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FilledButton.icon(
                              onPressed: onEnter,
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Entrar no painel'),
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton.icon(
                              onPressed: onBack,
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Voltar'),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: onBack,
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Voltar'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: onEnter,
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Entrar no painel'),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _IntroHero extends StatelessWidget {
  const _IntroHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.blue.withValues(alpha: 0.16),
                AppTheme.green.withValues(alpha: 0.16),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppTheme.border),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.satellite_alt_outlined,
                size: 42,
                color: AppTheme.blue,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppTheme.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: const Icon(Icons.eco, size: 18, color: AppTheme.green),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Dados espaciais a serviço do campo',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        Text(
          'O GalAgro organiza leituras orbitais demonstrativas em alertas climáticos para apoiar municípios rurais, equipes técnicas e pequenos produtores.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _IntroFeatureCard(
          icon: Icons.satellite_alt_outlined,
          tone: AppTheme.blue,
          title: 'Monitoramento orbital',
          description: 'Leituras de clima, solo e vegetação.',
        ),
        SizedBox(height: 10),
        _IntroFeatureCard(
          icon: Icons.warning_amber_rounded,
          tone: AppTheme.amber,
          title: 'Riscos climáticos',
          description: 'Seca, chuva intensa e calor extremo por região.',
        ),
        SizedBox(height: 10),
        _IntroFeatureCard(
          icon: Icons.shield_outlined,
          tone: AppTheme.green,
          title: 'Apoio municipal',
          description: 'Alertas para priorização de resposta em campo.',
        ),
      ],
    );
  }
}

class _IntroFeatureCard extends StatelessWidget {
  final IconData icon;
  final Color tone;
  final String title;
  final String description;

  const _IntroFeatureCard({
    required this.icon,
    required this.tone,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: tone),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 3),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
