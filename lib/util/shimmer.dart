import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// An enum defines all supported directions of shimmer effect
///
/// * [ShimmerDirection.ltr] left to right direction
/// * [ShimmerDirection.rtl] right to left direction
/// * [ShimmerDirection.ttb] top to bottom direction
/// * [ShimmerDirection.btt] bottom to top direction
///
enum ShimmerDirection { ltr, rtl, ttb, btt }

///
/// A widget renders shimmer effect over [child] widget tree.
///
/// [child] defines an area that shimmer effect blends on. You can build [child]
/// from whatever [Widget] you like but there're some notices in order to get
/// exact expected effect and get better rendering performance:
///
/// * Use static [Widget] (which is an instance of [StatelessWidget]).
/// * [Widget] should be a solid color element. Every colors you set on these
/// [Widget]s will be overridden by colors of [gradient].
/// * Shimmer effect only affects to opaque areas of [child], transparent areas
/// still stays transparent.
///
/// [duration] controls the speed of shimmer effect. The default value is 1500
/// milliseconds.
///
/// [interval] controls the interval between of shimmer effect repeating. If set NULL shimmer effect will be displayed one time. The default value is 5000
/// milliseconds.
///
/// [direction] controls the direction of shimmer effect. The default value
/// is [ShimmerDirection.ltr].
///
/// [gradient] controls colors of shimmer effect.
///
/// [blendMode] controls how to blend shimmer effect with children. The default value is [BlendMode.srcATop]
///
@immutable
class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration interval;
  final ShimmerDirection direction;
  final Gradient gradient;
  final BlendMode blendMode;

  const Shimmer({
    Key key,
    @required this.child,
    @required this.gradient,
    this.blendMode = BlendMode.srcATop,
    this.direction = ShimmerDirection.ltr,
    this.duration = const Duration(milliseconds: 1500),
    this.interval = const Duration(milliseconds: 5000),
  }) : super(key: key);

  ///
  /// A convenient constructor provides an easy and convenient way to create a
  /// [Shimmer] which [gradient] is [LinearGradient] made up of `baseColor` and
  /// `highlightColor`.
  ///
  Shimmer.fromColors({
    Key key,
    @required this.child,
    @required Color baseColor,
    @required Color highlightColor,
    this.blendMode = BlendMode.srcATop,
    this.duration = const Duration(milliseconds: 1500),
    this.interval = const Duration(milliseconds: 5000),
    this.direction = ShimmerDirection.ltr,
  })  : gradient = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              baseColor,
              baseColor,
              highlightColor,
              baseColor,
              baseColor
            ],
            stops: const <double>[
              0.0,
              0.35,
              0.5,
              0.65,
              1.0
            ]),
        super(key: key);

  @override
  _ShimmerState createState() => _ShimmerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient,
        defaultValue: null));
    properties.add(EnumProperty<ShimmerDirection>('direction', direction));
    properties.add(
        DiagnosticsProperty<Duration>('period', duration, defaultValue: null));
  }
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();

    if (widget.interval != null) {
      _timer = Timer.periodic(widget.interval, (timer) {
        _controller.reset();
        _controller.forward();
      });
    }
  }

  @override
  void didUpdateWidget(Shimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) => _Shimmer(
        child: child,
        direction: widget.direction,
        gradient: widget.gradient,
        blendMode: widget.blendMode,
        percent: _controller.value,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

@immutable
class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final ShimmerDirection direction;
  final Gradient gradient;
  final BlendMode blendMode;

  const _Shimmer({
    Widget child,
    this.percent,
    this.direction,
    this.gradient,
    this.blendMode,
  }) : super(child: child);

  @override
  _ShimmerMask createRenderObject(BuildContext context) {
    return _ShimmerMask(percent, direction, gradient, blendMode);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerMask mask) {
    mask.percent = percent;
    mask.gradient = gradient;
    mask.blendMode = blendMode;
  }
}

class _ShimmerMask extends RenderProxyBox {
  final ShimmerDirection _direction;
  Gradient _gradient;
  BlendMode _blendMode;
  double _percent;

  _ShimmerMask(
    this._percent,
    this._direction,
    this._gradient,
    this._blendMode,
  );

  @override
  ShaderMaskLayer get layer => super.layer;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double value) {
    assert(value != null);
    if (value == _percent) return;

    _percent = value;
    markNeedsPaint();
  }

  set gradient(Gradient value) {
    assert(value != null);
    if (value == _gradient) return;

    _gradient = value;
    markNeedsPaint();
  }

  set blendMode(BlendMode value) {
    assert(value != null);
    if (value == _blendMode) return;

    _blendMode = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      layer = null;
      return;
    }

    assert(needsCompositing);

    final double width = child.size.width;
    final double height = child.size.height;
    Rect rect;
    double dx, dy;
    if (_direction == ShimmerDirection.rtl) {
      dx = _calcOffset(width, -width, _percent);
      dy = 0.0;
      rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
    } else if (_direction == ShimmerDirection.ttb) {
      dx = 0.0;
      dy = _calcOffset(-height, height, _percent);
      rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
    } else if (_direction == ShimmerDirection.btt) {
      dx = 0.0;
      dy = _calcOffset(height, -height, _percent);
      rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
    } else {
      dx = _calcOffset(-width, width, _percent);
      dy = 0.0;
      rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
    }

    layer ??= ShaderMaskLayer();
    layer
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = _blendMode;

    context.pushLayer(layer, super.paint, offset);
  }

  double _calcOffset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}
