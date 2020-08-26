import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fplayground/util/path_metric_helper.dart';

class StarLinePainter extends CustomPainter {
  Animation<double> animation;
  Path path;

  StarLinePainter({@required this.animation, @required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    if (null == this.path || 0.0 == this.animation.value) return;

    final path = PathMetricHelper.createAnimatedPath(
      this.path,
      this.animation.value,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.orangeAccent.shade200
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 6)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
