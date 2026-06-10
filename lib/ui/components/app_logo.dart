import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:galagro/ui/theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double? iconSize;
  final double? height;
  final double textSize;
  final bool showWordmark;
  final double spacing;

  const AppLogo({
    super.key,
    this.iconSize,
    this.height,
    this.textSize = 22,
    this.showWordmark = true,
    this.spacing = 10,
  });

  double get _resolvedHeight => height ?? iconSize ?? 42;
  double get _resolvedWidth => _resolvedHeight * (104 / 178);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: _resolvedHeight,
          width: _resolvedWidth,
          child: const CustomPaint(painter: _GalAgroMarkPainter()),
        ),
        if (showWordmark) ...[
          SizedBox(width: spacing),
          _GalAgroWordmark(textSize: textSize),
        ],
      ],
    );
  }
}

class _GalAgroWordmark extends StatelessWidget {
  final double textSize;

  const _GalAgroWordmark({required this.textSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        children: const [
          TextSpan(
            text: 'Gal',
            style: TextStyle(color: AppTheme.blue),
          ),
          TextSpan(
            text: 'Agro',
            style: TextStyle(color: AppTheme.green),
          ),
        ],
      ),
    );
  }
}

class _GalAgroMarkPainter extends CustomPainter {
  const _GalAgroMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / 104;
    final scaleY = size.height / 178;

    canvas.save();
    canvas.scale(scaleX, scaleY);
    canvas.translate(-92, -28);

    final orbitPaint = Paint()
      ..color = AppTheme.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    final leafPaint = Paint()
      ..color = AppTheme.green
      ..style = PaintingStyle.fill;

    final veinPaint = Paint()
      ..color = const Color(0x990C7A3A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final stemPaint = Paint()
      ..color = AppTheme.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.5
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.translate(130, 112);
    canvas.rotate(-18 * math.pi / 180);
    final orbitRect = Rect.fromCenter(
      center: Offset.zero,
      width: 200,
      height: 72,
    );
    canvas.drawOval(orbitRect, orbitPaint);
    canvas.restore();

    final stemPath = Path()
      ..moveTo(123, 172)
      ..cubicTo(121, 182, 118, 190, 116, 199);
    canvas.drawPath(stemPath, stemPaint);

    final leafPath = Path()
      ..moveTo(138, 34)
      ..cubicTo(188, 78, 180, 128, 122, 174)
      ..cubicTo(96, 124, 102, 70, 138, 34)
      ..close();
    canvas.drawPath(leafPath, leafPaint);

    final veinPath = Path()
      ..moveTo(136, 48)
      ..cubicTo(131, 86, 130, 122, 121, 174);
    canvas.drawPath(veinPath, veinPaint);

    canvas.save();
    canvas.translate(130, 112);
    canvas.rotate(-18 * math.pi / 180);
    final frontArcRect = Rect.fromCenter(
      center: Offset.zero,
      width: 200,
      height: 72,
    );
    final frontArc = Path()
      ..addArc(frontArcRect, 0.72 * math.pi, 0.96 * math.pi);
    canvas.drawPath(frontArc, orbitPaint);
    canvas.restore();

    final dotPaint = Paint()
      ..color = AppTheme.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(211, 70), 6.5, dotPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
