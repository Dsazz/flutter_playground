import 'package:flutter/material.dart';

import 'base_animation.dart';

class GrowAnimation extends StatefulWidget implements BaseAnimation {
  VoidCallback _onPressed;

  @override
  void onPressed() {
    return _onPressed();
  }

  @override
  _GrowAnimationState createState() {
    _GrowAnimationState state = _GrowAnimationState();
    _onPressed = state.onPressed;

    return state;
  }
}

class _GrowAnimationState extends State<GrowAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween<double>(begin: 0, end: 100).animate(_controller);
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
        return Container(
          height: _animation.value,
          width: _animation.value,
          child: const FlutterLogo(),
        );
      },
    );
  }
}
