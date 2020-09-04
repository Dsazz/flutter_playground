import 'dart:math';

import 'package:flatter_playground/util/util.dart';
import 'package:flutter/material.dart';

import 'base_animation.dart';

class RotateAnimation extends StatefulWidget implements BaseAnimation {
  RotateAnimation({GlobalKey key}) : super(key: key);

  @override
  void onPressed() {
    var state = cast<GlobalKey>(key).currentState;
    return cast<_RotateAnimationState>(state).onPressed();
  }

  @override
  _RotateAnimationState createState() => _RotateAnimationState();
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
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
        setState(() {});
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
    );
  }
}
