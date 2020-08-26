import 'dart:ui';

import 'package:flutter/material.dart';

class CustomClipperOval extends CustomClipper<Rect> {
  double radiusShift = 0.0;

  CustomClipperOval({this.radiusShift});

  @override
  Rect getClip(Size size) {
    final halfWidth = size.width * 0.5;
    return Rect.fromCircle(
      center: Offset(halfWidth, halfWidth),
      radius: halfWidth + radiusShift,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
