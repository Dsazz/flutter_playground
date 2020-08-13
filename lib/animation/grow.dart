import 'package:flutter/material.dart';
import 'package:fplayground/animation/base_animation.dart';

class GrowAnimation extends StatefulWidget implements BaseAnimation {
  GrowAnimationState state;

  @override
  VoidCallback onPressed() {
    print("CLICKED");
    print("${state.onPressed}");
    return this.state.onPressed;
  }

  @override
  GrowAnimationState createState() {
    this.state = GrowAnimationState();

    return state;
  }
}

class GrowAnimationState extends State<GrowAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..addStatusListener((state) => print('$state'))
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween<double>(begin: 0, end: 100).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onPressed() {
    print("CLICKED INTERNAL");
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
