import 'package:flutter/material.dart';
import 'package:galagro/ui/components/app_logo.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class GalagroTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showLogo;
  final Widget? leading;

  const GalagroTopAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.actions,
    this.showLogo = false,
    this.leading,
  });

  @override
  Size get preferredSize => Size.fromHeight(subtitle == null ? 70 : 86);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      titleSpacing: 18,
      toolbarHeight: subtitle == null ? 70 : 86,
      title: showLogo
          ? const AppLogo(height: 28, textSize: 20)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
      actions: actions,
    );
  }
}
