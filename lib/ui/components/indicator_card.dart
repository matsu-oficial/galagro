import 'package:flutter/material.dart';
import 'package:galagro/ui/components/section_card.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class IndicatorCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color tone;
  final double? progress;

  const IndicatorCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.tone,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      color: AppTheme.cardAlt,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: tone, size: 15),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            softWrap: true,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
          ),
          if (progress != null) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress!.clamp(0, 1),
                backgroundColor: AppTheme.border,
                valueColor: AlwaysStoppedAnimation<Color>(tone),
                minHeight: 3.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
