import 'package:flatter_playground/util/util.dart';
import 'package:flutter/material.dart';

import 'base_animation.dart';

class GrowAnimation extends StatefulWidget implements BaseAnimation {
  GrowAnimation({GlobalKey key}) : super(key: key);

  @override
  void onPressed() {
    var state = cast<GlobalKey>(key).currentState;
    return cast<_GrowAnimationState>(state).onPressed();
  }

  @override
  _GrowAnimationState createState() => _GrowAnimationState();
}

class _GrowAnimationState extends State<GrowAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
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
