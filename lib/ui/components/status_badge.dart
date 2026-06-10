import 'package:flutter/material.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const StatusBadge({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: color ?? _statusColor(label),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String label) {
    switch (label) {
      case 'Atenção':
      case 'Atencao':
      case 'Ativo':
        return AppTheme.amber;
      case 'Monitoramento ativo':
      case 'Resolvido':
        return AppTheme.green;
      case 'Novo':
      case 'Em análise':
      case 'Em analise':
        return AppTheme.blue;
      default:
        return AppTheme.textMuted;
    }
  }
}
