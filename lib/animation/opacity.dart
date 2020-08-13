import 'package:flutter/material.dart';
import 'package:fplayground/animation/base_animation.dart';

class OpacityAnimation extends StatefulWidget implements BaseAnimation {
  _OpacityAnimationState state;

  @override
  VoidCallback onPressed() {
    return state.onPressed;
  }

  @override
  _OpacityAnimationState createState() {
    this.state = _OpacityAnimationState();

    return this.state;
  }
}

class _OpacityAnimationState extends State<OpacityAnimation> {
  final show = 1.0;
  final hide = 0.0;

  bool _visible = false;

  void onPressed() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? show : hide,
      duration: const Duration(seconds: 1),
      child: const FlutterLogo(size: 100),
    );
  }
}
