import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galagro/ui/components/app_logo.dart';
import 'package:galagro/ui/components/sim_note.dart';
import 'package:galagro/ui/theme/app_theme.dart';
import 'package:galagro/ui/theme/responsive_layout.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const SplashScreen({super.key, required this.onFinished});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), widget.onFinished);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: widget.onFinished,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final compact = ResponsiveLayout.isCompact(width);
            final iconSize = width >= 960
                ? 156.0
                : compact
                ? 128.0
                : 142.0;
            final wordmarkSize = compact ? 27.0 : 31.0;

            return Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.18),
                  radius: 1.1,
                  colors: [Color(0x1838BDF8), AppTheme.background],
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: compact ? 24 : 32,
                        vertical: compact ? 24 : 32,
                      ),
                      child: Column(
                        children: [
                          const Spacer(),
                          AppLogo(height: iconSize, showWordmark: false),
                          const SizedBox(height: 14),
                          AppLogo(
                            height: 0,
                            textSize: wordmarkSize,
                            showWordmark: true,
                            spacing: 0,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Monitoramento agroespacial inteligente',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: compact ? 14 : 15,
                                  color: AppTheme.textSecondary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: compact ? 106 : 116,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: const LinearProgressIndicator(
                                minHeight: 4,
                                backgroundColor: AppTheme.border,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.green,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const SimNote(text: 'Leitura orbital demonstrativa'),
                          const SizedBox(height: 22),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
