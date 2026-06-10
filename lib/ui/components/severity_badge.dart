import 'package:flutter/material.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class SeverityBadge extends StatelessWidget {
  final String severity;

  const SeverityBadge({super.key, required this.severity});

  @override
  Widget build(BuildContext context) {
    final config = _severityConfig(severity);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: config.background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: config.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: config.dot,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            severity,
            style: TextStyle(
              color: config.text,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeConfig _severityConfig(String severity) {
    switch (severity) {
      case 'Crítico':
      case 'Critico':
        return _BadgeConfig(
          background: AppTheme.red.withValues(alpha: 0.14),
          border: AppTheme.red.withValues(alpha: 0.36),
          dot: AppTheme.red,
          text: const Color(0xFFFDB4B4),
        );
      case 'Alto':
        return _BadgeConfig(
          background: AppTheme.amber.withValues(alpha: 0.14),
          border: AppTheme.amber.withValues(alpha: 0.36),
          dot: AppTheme.amber,
          text: const Color(0xFFFCD98A),
        );
      case 'Baixo':
        return _BadgeConfig(
          background: AppTheme.green.withValues(alpha: 0.14),
          border: AppTheme.green.withValues(alpha: 0.36),
          dot: AppTheme.green,
          text: const Color(0xFF97E7B3),
        );
      default:
        return _BadgeConfig(
          background: AppTheme.blue.withValues(alpha: 0.14),
          border: AppTheme.blue.withValues(alpha: 0.36),
          dot: AppTheme.blue,
          text: const Color(0xFFA3E1FB),
        );
    }
  }
}

class _BadgeConfig {
  final Color background;
  final Color border;
  final Color dot;
  final Color text;

  const _BadgeConfig({
    required this.background,
    required this.border,
    required this.dot,
    required this.text,
  });
}
