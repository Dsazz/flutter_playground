import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fplayground/animation/base_animation.dart';

class RotateAnimation extends StatefulWidget implements BaseAnimation {
  _RotateAnimationState state;

  @override
  VoidCallback onPressed() {
    return state.onPressed;
  }

  @override
  _RotateAnimationState createState() {
    this.state = _RotateAnimationState();

    return this.state;
  }
}

class _RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void onPressed() {
    _controller.isCompleted ? _controller.reverse() : _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addStatusListener((status) {
            debugPrint("-------> $status");
          })
          ..addListener(() {
            setState(() {
              debugPrint("Curved: ${_controller.value}");
            });
          });

    _animation = Tween(begin: 0.0, end: pi)
        .chain(CurveTween(curve: Curves.easeInToLinear))
        .animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: const Icon(
        Icons.expand_more,
        size: 50.0,
        color: Colors.black,
      ),
      builder: (context, child) => Transform.rotate(
        angle: _animation.value,
        child: child,
      ),
//  child:
    );
  }
}
