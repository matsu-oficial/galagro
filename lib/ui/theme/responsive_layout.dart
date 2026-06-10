import 'dart:math' as math;

import 'package:flutter/material.dart';

class ResponsiveLayout {
  static bool isCompact(double width) => width < 560;

  static bool isDesktop(double width) => width >= 960;

  static double maxContentWidth(double width) {
    if (width >= 1280) {
      return 1120;
    }
    if (width >= 960) {
      return 960;
    }
    return width;
  }

  static EdgeInsets pagePadding(double width) {
    if (width >= 960) {
      return const EdgeInsets.fromLTRB(32, 16, 32, 32);
    }
    if (width >= 560) {
      return const EdgeInsets.fromLTRB(24, 12, 24, 28);
    }
    return const EdgeInsets.fromLTRB(20, 8, 20, 24);
  }

  static int metricColumns(double width) {
    if (width >= 1040) {
      return 4;
    }
    if (width >= 360) {
      return 2;
    }
    return 1;
  }

  static int indicatorColumns(double width) {
    if (width >= 1040) {
      return 4;
    }
    if (width >= 360) {
      return 2;
    }
    if (width >= 680) {
      return 2;
    }
    return 1;
  }

  static double boundedWidth(double width) {
    return math.min(width, maxContentWidth(width));
  }
}

class ResponsiveContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ResponsiveContent({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveLayout.maxContentWidth(width),
            ),
            child: Padding(
              padding: padding ?? ResponsiveLayout.pagePadding(width),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
