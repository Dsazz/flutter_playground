import 'package:flatter_playground/util/util.dart';
import 'package:flutter/material.dart';

class CircleLoader extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Color color3;
  final Size size;

  const CircleLoader({
    this.color1 = Colors.deepOrangeAccent,
    this.color2 = Colors.amber,
    this.color3 = Colors.lightGreen,
    this.size = const Size(100, 100),
  });

  @override
  _CircleLoaderState createState() => _CircleLoaderState();
}

class _CircleLoaderState extends State<CircleLoader>
    with TickerProviderStateMixin {
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;

  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);

    controller2 = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);

    controller3 = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller1, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation2 = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller2, curve: Interval(0.0, 1.0, curve: Curves.easeIn)));

    animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller3,
        curve: Interval(0.0, 1.0, curve: Curves.decelerate)));

    controller1.repeat();
    controller2.repeat();
    controller3.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          CircleItemLoader(
            animation: animation1,
            painter: Arc1Painter(widget.color1),
            size: widget.size,
          ),
          CircleItemLoader(
            animation: animation2,
            painter: Arc2Painter(widget.color2),
            size: widget.size,
          ),
          CircleItemLoader(
            animation: animation3,
            painter: Arc3Painter(widget.color3),
            size: widget.size,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
}

class CircleItemLoader extends StatelessWidget {
  final Animation<double> animation;
  final CustomPainter painter;
  final Size size;

  const CircleItemLoader({
    @required this.animation,
    @required this.painter,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animation,
      child: CustomPaint(
        painter: painter,
        child: SizedBox.fromSize(size: size),
      ),
    );
  }
}

class Arc1Painter extends CustomPainter {
  final Color color;

  Arc1Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p1 = new Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect1 = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    canvas.drawArc(rect1, degToRad(0), degToRad(90), false, p1);
    canvas.drawArc(rect1, degToRad(120), degToRad(90), false, p1);
    canvas.drawArc(rect1, degToRad(240), degToRad(90), false, p1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc2Painter extends CustomPainter {
  final Color color;

  Arc2Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p2 = new Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double scaleWidth = 0.2 * size.width;
    double scaleHeight = 0.2 * size.height;

    Rect rect2 = new Rect.fromLTWH(
      scaleWidth * 0.5,
      scaleHeight * 0.5,
      size.width - scaleWidth,
      size.height - scaleHeight,
    );

    canvas.drawArc(rect2, degToRad(0), degToRad(90), false, p2);
    canvas.drawArc(rect2, degToRad(140), degToRad(120), false, p2);
    canvas.drawArc(rect2, degToRad(290), degToRad(40), false, p2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc3Painter extends CustomPainter {
  final Color color;

  Arc3Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p3 = new Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double scaleWidth = 0.4 * size.width;
    double scaleHeight = 0.4 * size.height;

    Rect rect3 = new Rect.fromLTWH(
      scaleWidth * 0.5,
      scaleHeight * 0.5,
      size.width - scaleWidth,
      size.height - scaleHeight,
    );

    canvas.drawArc(rect3, degToRad(0), degToRad(150), false, p3);
    canvas.drawArc(rect3, degToRad(180), degToRad(160), false, p3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
