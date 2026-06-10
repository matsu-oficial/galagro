import 'package:flutter/material.dart';
import 'package:galagro/ui/components/section_card.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color tone;

  const MetricCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      color: AppTheme.cardAlt,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: tone, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 27),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            softWrap: true,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
