import 'package:flutter/material.dart';

import '_dot.dart';

class BouncingDotsLoader extends StatefulWidget {
  final Color dotOneColor;
  final Color dotTwoColor;
  final Color dotThreeColor;
  final Duration duration;
  final IconData dotIcon;
  final double dotSize;

  const BouncingDotsLoader({
    this.dotOneColor = Colors.amber,
    this.dotTwoColor = Colors.orangeAccent,
    this.dotThreeColor = Colors.orange,
    this.dotSize = 10,
    this.dotIcon = Icons.blur_on,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  _BouncingDotsLoaderState createState() => _BouncingDotsLoaderState();
}

class _BouncingDotsLoaderState extends State<BouncingDotsLoader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;

  Dot dot1;
  Dot dot2;
  Dot dot3;

  @override
  void initState() {
    super.initState();

    dot1 = Dot(
      radius: widget.dotSize,
      color: widget.dotOneColor,
      icon: widget.dotIcon,
    );
    dot2 = Dot(
      radius: widget.dotSize,
      color: widget.dotTwoColor,
      icon: widget.dotIcon,
    );
    dot3 = Dot(
      radius: widget.dotSize,
      color: widget.dotThreeColor,
      icon: widget.dotIcon,
    );

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.70, curve: Curves.ease),
      ),
    );

    animation2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.1, 0.8, curve: Curves.ease),
      ),
    );

    animation3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.90, curve: Curves.ease),
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _BouncingDot(animation: animation1, dot: dot1),
          _BouncingDot(animation: animation2, dot: dot2),
          _BouncingDot(animation: animation3, dot: dot3),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _BouncingDot extends StatelessWidget {
  final Animation<double> animation;
  final Dot dot;

  const _BouncingDot({
    Key key,
    @required this.animation,
    @required this.dot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        0.0,
        -30 *
            (animation.value <= 0.50 ? animation.value : 1.0 - animation.value),
      ),
      child: Padding(padding: const EdgeInsets.only(right: 8.0), child: dot),
    );
  }
}
