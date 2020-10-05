import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  final IconData icon;

  const Dot({this.radius, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(icon, color: color, size: radius),
    );
  }
}
