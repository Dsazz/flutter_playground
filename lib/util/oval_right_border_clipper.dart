import 'package:flutter/material.dart';

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final heightTo = size.height * 0.25;
    final widthTo = size.width - 40;

    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(widthTo, 0);
    path.quadraticBezierTo(size.width, heightTo, size.width, size.height * 0.5);
    path.quadraticBezierTo(
      size.width,
      size.height - heightTo,
      widthTo,
      size.height,
    );
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
