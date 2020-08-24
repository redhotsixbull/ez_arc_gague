import 'dart:math' as math;
import 'package:flutter/material.dart';

class GradientArcPainterDemo extends StatefulWidget {
  GradientArcPainterDemo(
      {Key key,
      this.value,
      this.startColor,
      this.endColor,
      this.width,
      this.startAngle,
      this.endAngle,
      this.backgroundColor})
      : super(key: key);
  final double value;
  final Color startColor;
  final Color endColor;
  final Color backgroundColor;
  final double width;
  final double startAngle;
  final double endAngle;

  @override
  GradientArcPainterDemoState createState() => GradientArcPainterDemoState();
}

class GradientArcPainterDemoState extends State<GradientArcPainterDemo>
    with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Color startColor = widget.startColor;
    Color endColor = widget.endColor;
    Color backgroundColor = widget.backgroundColor;
    double _progress = widget.value;
    double width = widget.width;
    double startAngle = widget.startAngle;
    double endAngle = widget.endAngle;

    return GestureDetector(
      onTap: () {
        setState(() {
          print("");
        });
      },
      child: new Center(
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: Stack(
            children: <Widget>[
              CustomPaint(
                  painter: GradientArcPainter(
                      progress: _progress,
                      startColor: startColor,
                      endColor: endColor,
                      width: width,
                      fraction: _fraction,
                      startAngle: startAngle,
                      endAngle: endAngle,
                      backgroundColor: backgroundColor),
                  child: Center()),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientArcPainter extends CustomPainter {
  const GradientArcPainter({
    @required this.progress,
    @required this.startColor,
    @required this.endColor,
    @required this.backgroundColor,
    @required this.width,
    @required this.startAngle,
    @required this.endAngle,
    @required this.fraction,
  })  : assert(progress != null),
        assert(startColor != null),
        assert(endColor != null),
        assert(width != null),
        assert(startAngle != null),
        assert(endAngle != null),
        super();
  final double fraction;
  final double progress;
  final Color startColor;
  final Color endColor;
  final Color backgroundColor;
  final double width;
  final double startAngle;
  final double endAngle;

  @override
  void paint(Canvas canvas, Size size) {
    print('paint $fraction');

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = new SweepGradient(
      startAngle: math.pi * 0.7,
      endAngle: math.pi * 2.6,
      tileMode: TileMode.repeated,
      colors: [startColor, endColor],
    );

    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (width / 2);
    final startAngleValue = math.pi * startAngle;

    final paint2 = new Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap
          .butt //gradation is not adjust in StrokeCap.round not recommend
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final endAngleValue = math.pi * 1.6;

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngleValue, endAngleValue * fraction, false, paint2);

    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final sweepAngle = math.pi * progress * endAngle;

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngleValue, sweepAngle * fraction, false, paint);
  }

  @override
  bool shouldRepaint(GradientArcPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
