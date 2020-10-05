import 'package:flatter_playground/util/util.dart';
import 'package:flutter/material.dart';

import 'base_animation.dart';

class OpacityAnimation extends StatefulWidget implements BaseAnimation {
  const OpacityAnimation({GlobalKey key}) : super(key: key);

  @override
  void onPressed() {
    var state = cast<GlobalKey>(key).currentState;
    return cast<_OpacityAnimationState>(state).onPressed();
  }

  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
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
