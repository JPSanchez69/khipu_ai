import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/khipu_theme.dart';
import '../../../domain/lesson_script/board_state.dart';

class WhiteboardCanvas extends StatelessWidget {
  const WhiteboardCanvas({
    super.key,
    required this.state,
    this.progress = 1.0,
  });

  final BoardState state;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: KhipuTheme.board,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: KhipuTheme.forest.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CustomPaint(
          painter: WhiteboardPainter(state: state),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class WhiteboardPainter extends CustomPainter {
  WhiteboardPainter({required this.state});

  final BoardState state;

  @override
  void paint(Canvas canvas, Size size) {
    // Soft chalk grid
    final grid = Paint()
      ..color = const Color(0xFF1A5C45)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (var y = 0.0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    for (final e in state.elements) {
      if (e.highlighted) {
        final glow = Paint()
          ..color = e.highlightColor.withValues(alpha: 0.35)
          ..style = PaintingStyle.fill;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(e.x - 8, e.y - 8, _contentWidth(e) + 16, 40),
            const Radius.circular(8),
          ),
          glow,
        );
      }

      final paint = Paint()
        ..color = e.kind == BoardElementKind.text
            ? e.color
            : const Color(0xFFE9F5EC)
        ..style = PaintingStyle.stroke
        ..strokeWidth = e.strokeWidth
        ..strokeCap = StrokeCap.round;

      switch (e.kind) {
        case BoardElementKind.text:
          _drawText(canvas, e, chalk: true);
        case BoardElementKind.circle:
          canvas.drawOval(
            Rect.fromLTWH(e.x, e.y, e.width, e.height),
            paint..color = e.color,
          );
        case BoardElementKind.rect:
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(e.x, e.y, e.width, e.height),
              const Radius.circular(6),
            ),
            paint..color = e.color,
          );
        case BoardElementKind.line:
          canvas.drawLine(
            Offset(e.x, e.y),
            Offset(e.toX ?? e.x + e.width, e.toY ?? e.y),
            paint..color = e.color,
          );
        case BoardElementKind.arrow:
          _drawArrow(
            canvas,
            Offset(e.x, e.y),
            Offset(e.toX ?? e.x + 40, e.toY ?? e.y + 40),
            paint..color = e.color,
          );
        case BoardElementKind.timeline:
          final linePaint = Paint()
            ..color = const Color(0xFFB7E4C7)
            ..strokeWidth = 3;
          canvas.drawLine(
            Offset(e.x, e.y + 12),
            Offset(e.x + e.width, e.y + 12),
            linePaint,
          );
          canvas.drawCircle(Offset(e.x, e.y + 12), 6, linePaint);
          _drawText(
            canvas,
            e.copyWith(y: e.y + 22),
            chalk: true,
            forceColor: const Color(0xFFE9F5EC),
          );
        case BoardElementKind.concept:
          final fill = Paint()
            ..color = e.color.withValues(alpha: 0.85)
            ..style = PaintingStyle.fill;
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(e.x, e.y, e.width, e.height),
              const Radius.circular(14),
            ),
            fill,
          );
          _drawText(
            canvas,
            e.copyWith(x: e.x + 12, y: e.y + 12),
            chalk: true,
            forceColor: Colors.white,
          );
      }
    }
  }

  double _contentWidth(BoardElement e) {
    if (e.text != null) return e.text!.length * (e.fontSize * 0.55);
    return e.width;
  }

  void _drawText(
    Canvas canvas,
    BoardElement e, {
    required bool chalk,
    Color? forceColor,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: e.text ?? '',
        style: TextStyle(
          color: forceColor ?? (chalk ? const Color(0xFFE9F5EC) : e.color),
          fontSize: e.fontSize,
          fontWeight: FontWeight.w600,
          fontFamily: 'RobotoMono',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 320);
    tp.paint(canvas, Offset(e.x, e.y));
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, Paint paint) {
    canvas.drawLine(from, to, paint);
    final angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const size = 12.0;
    final path = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(
        to.dx - size * math.cos(angle - 0.4),
        to.dy - size * math.sin(angle - 0.4),
      )
      ..moveTo(to.dx, to.dy)
      ..lineTo(
        to.dx - size * math.cos(angle + 0.4),
        to.dy - size * math.sin(angle + 0.4),
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WhiteboardPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
