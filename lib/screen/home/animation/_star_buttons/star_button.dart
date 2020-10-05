import 'dart:ui';

import 'package:flatter_playground/service/audio_player.dart';
import 'package:flatter_playground/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

typedef StarActionCallback = void Function(Offset currPnt, bool isForward);

class AnimatedStarButton extends StatefulWidget {
  static const IDX_PREFIX = "star_";

  static const double SIZE = 46;
  static const double RADIUS = SIZE * 0.5;
  static const double RADIUS_SHIFT = 3;
  static const double SHADOW_SHIFT = SIZE * 0.25;

  final Offset actionPoint;
  final String index;

  void tryDoAction(Offset currPnt, bool isForward) {
    var state = cast<GlobalKey>(key).currentState;
    if (state == null) {
      return;
    }

    return cast<AnimatedStarButtonState>(state).tryDoAction(currPnt, isForward);
  }

  const AnimatedStarButton({GlobalKey key, int index, this.actionPoint})
      : this.index = IDX_PREFIX + "$index",
        super(key: key);

  @override
  AnimatedStarButtonState createState() {
    AnimatedStarButtonState state = AnimatedStarButtonState();

    return state;
  }
}

class AnimatedStarButtonState extends State<AnimatedStarButton>
    with TickerProviderStateMixin {
  AudioPlayerController player = GetIt.I<AudioPlayerController>();

  AnimationController controller;
  Animation<double> animation;

  AnimationController btnController;
  Animation<double> btnAnimation;

  bool actionTaken = false;

  AnimatedStarButtonState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    animation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: 0.40),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.40, end: 0.0),
          weight: 50.0,
        ),
      ],
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.02,
          0.04,
          curve: Curves.easeInOutCirc,
        )))
      ..addListener(() {
        setState(() {});
      });

    btnController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
    btnController.repeat(reverse: true);
    btnAnimation = Tween(begin: 1.0, end: 5.0).animate(btnController);
  }

  bool _shouldDoAction(Offset currPnt, bool isForward) {
    if ((isForward && actionTaken) ||
        (false == isForward && false == actionTaken)) {
      return false;
    }

    bool isAfterCurrent = isForward
        ? (currPnt.dx > widget.actionPoint.dx)
        : (currPnt.dx > 0 && ((currPnt.dx - widget.actionPoint.dx) <= 0));

    return currPnt == widget.actionPoint || isAfterCurrent;
  }

  void tryDoAction(Offset currPnt, bool isForward) {
    if (_shouldDoAction(currPnt, isForward)) {
      _doAction(isForward);
    }
  }

  void _doAction(bool isForward) {
    player.play(widget.index);

    controller.reset();
    controller.forward();

    actionTaken = isForward;
  }

  @override
  void dispose() {
    controller.dispose();
    btnController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1 + animation.value,
      child: SizedBox(
        width: AnimatedStarButton.SIZE,
        height: AnimatedStarButton.SIZE,
        child: GestureDetector(
          onTap: _onTap,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          child: StarButtonBody(btnAnimation: btnAnimation),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    controller.reverse();
  }

  void _onTap() {}
}

class StarButtonBody extends StatelessWidget {
  const StarButtonBody({
    Key key,
    @required this.btnAnimation,
  }) : super(key: key);

  final Animation<double> btnAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.amber,
            blurRadius: btnAnimation.value,
            spreadRadius: btnAnimation.value,
          )
        ],
      ),
      child: const StarIcon(),
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const <Widget>[
        const Positioned(
          top: AnimatedStarButton.SHADOW_SHIFT,
          left: AnimatedStarButton.SHADOW_SHIFT,
          child: const Icon(Icons.star, color: Colors.black38),
        ),
        const Icon(Icons.star, color: Colors.orange),
      ],
    );
  }
}
