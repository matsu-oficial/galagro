import 'package:flutter/material.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class SimNote extends StatelessWidget {
  final String text;

  const SimNote({
    super.key,
    this.text = 'Dados simulados para fins acadêmicos',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 7,
          height: 7,
          margin: const EdgeInsets.only(top: 4.5),
          decoration: const BoxDecoration(
            color: AppTheme.blue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            softWrap: true,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
