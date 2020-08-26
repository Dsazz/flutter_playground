import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fplayground/screen/home/animation/base_animation.dart';
import 'package:fplayground/util/path_metric_helper.dart';
import 'package:fplayground/util/util.dart';

import '_star_buttons/star_button.dart';
import '_star_buttons/star_line_painter.dart';
import '_star_buttons/star_line_path.dart';

class AnimatedStarButtonsPainter extends StatefulWidget
    implements BaseAnimation {
  VoidCallback _onPressed;

  @override
  void onPressed() {
    return _onPressed();
  }

  @override
  AnimatedStarButtonsState createState() {
    AnimatedStarButtonsState state = AnimatedStarButtonsState();
    _onPressed = state.onPressed;

    return state;
  }
}

class AnimatedStarButtonsState extends State<AnimatedStarButtonsPainter>
    with TickerProviderStateMixin {
  List<AnimatedStarButton> _animatedButtons = [];

  GlobalKey _drawStack = GlobalKey();

  AnimationController _lineController;
  Animation<double> _lineAnimation;

  Size _mainSize;
  Path _path;

  void onPressed() {
    _lineController.isCompleted
        ? _lineController.reverse()
        : _lineController.forward();
  }

  void _initButtons() {
    final height = _mainSize.height * 0.5;
    final dx1 = _mainSize.width * 0.1;
    final dx2 = _mainSize.width * 0.39;
    final dx3 = _mainSize.width * 0.68;

    _animatedButtons.add(AnimatedStarButton(1, Offset(dx1, height)));
    _animatedButtons.add(AnimatedStarButton(2, Offset(dx2, height)));
    _animatedButtons.add(AnimatedStarButton(3, Offset(dx3, height)));
  }

  @override
  void initState() {
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..addListener(() {
        setState(() {});
      });

    _lineAnimation = Tween(begin: 0.0, end: 1.0).animate(_lineController)
      ..addListener(() {});

    Future.delayed(Duration.zero, () {
      _path = StarLinePath.build(context.size);
    });

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setMainSize();
      _initButtons();
    });
  }

  void _setMainSize() {
    RenderBox mainBox = _drawStack.currentContext.findRenderObject();
    _mainSize = mainBox.size;
    setState(() {});
  }

  @override
  void dispose() {
    _lineController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Icon icon = const Icon(Icons.star, size: 18);
    return Stack(
      key: _drawStack,
      fit: StackFit.expand,
      children: <Widget>[
        CustomPaint(
          painter: StarLinePainter(animation: _lineAnimation, path: _path),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _animatedButtons,
          ),
        ),
        buildMovingStar(icon),
      ],
    );
  }

  Positioned buildMovingStar(Icon icon) {
    Offset pos = PathMetricHelper.getAnimatedBlockPosition(
      _path,
      _lineAnimation.value,
      icon.size,
    );

    _animatedButtons?.forEach((element) => element.tryDoAction(pos));

    return Positioned(
      top: pos.dy,
      left: pos.dx,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return ui.Gradient.radial(Offset(0, 9.0), degToRad(180), [
            Colors.orangeAccent,
            Colors.orange,
            Colors.orangeAccent,
            Colors.orange,
          ], [
            0.0,
            0.4,
            0.8,
            1.0
          ]);
        },
        child: icon,
      ),
    );
  }
}
