import 'package:flutter/material.dart';

import 'base_animation.dart';

class OpacityAnimation extends StatefulWidget implements BaseAnimation {
  VoidCallback _onPressed;

  @override
  void onPressed() {
    return _onPressed();
  }

  @override
  _OpacityAnimationState createState() {
    _OpacityAnimationState state = _OpacityAnimationState();
    _onPressed = state.onPressed;

    return state;
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
