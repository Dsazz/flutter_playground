import 'dart:math';

import 'package:flatter_playground/util/util.dart';
import 'package:flutter/material.dart';

import 'base_animation.dart';

class WaveAnimation extends StatefulWidget implements BaseAnimation {
  final double height;
  final double speed;
  final double offset;

  WaveAnimation({GlobalKey key, this.height, this.speed, this.offset = 0.0})
      : super(key: key);

  @override
  void onPressed() {
    var state = cast<GlobalKey>(key).currentState;
    return cast<WaveAnimationState>(state).onPressed();
  }

  @override
  WaveAnimationState createState() {
    WaveAnimationState state = WaveAnimationState(
      height: this.height,
      speed: this.speed,
      offset: this.offset,
    );

    return state;
  }
}

class WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  final double height;
  final double speed;
  final double offset;

  WaveAnimationState({this.height, this.speed, this.offset});

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (5000 / speed).round()),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void onPressed() {
    _controller.isCompleted ? _controller.reverse() : _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return LayoutBuilder(builder: (context, constraints) {
          return Container(
            height: height,
            width: constraints.biggest.width,
            child: CustomPaint(
              foregroundPainter: CurvePainter(_animation.value + offset),
            ),
          );
        });
      },
    );
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final color = Paint()..color = Colors.black.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
      size.width * 0.5,
      controlPointY,
      size.width,
      endPointY,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
