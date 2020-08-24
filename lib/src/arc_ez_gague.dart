import 'dart:math' as math;
import 'package:flutter/material.dart';

class GradientArcPainterDemo extends StatefulWidget {
  GradientArcPainterDemo({Key key, this.value})
      : super(key: key);
  final double value;

  @override
  GradientArcPainterDemoState createState() => GradientArcPainterDemoState();
}

class GradientArcPainterDemoState extends State<GradientArcPainterDemo> with SingleTickerProviderStateMixin{

  double _fraction = 0.0;
  Animation<double> animation;
  Color startColor =  Color(0xff64aef8);
  Color endColor =  Color(0xff2644eb);

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
    double _progress = widget.value;
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
                      width: 8.0,
                      fraction :_fraction
                  ),
                  child: Center()
              ),
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
    @required this.width,
    @required this.fraction,
  })  : assert(progress != null),
        assert(startColor != null),
        assert(endColor != null),
        assert(width != null),
        super();
  final double fraction;
  final double progress;
  final Color startColor;
  final Color endColor;
  final double width;

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
    final startAngle = math.pi * 0.7;

    final paint2 = new Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.butt //gradation is not adjust in StrokeCap.round not recommend
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final endAngle = math.pi * 1.6;

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, endAngle *fraction, false, paint2);

    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final sweepAngle = math.pi * progress * 1.6;

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle * fraction , false, paint);
  }

  @override
  bool shouldRepaint(GradientArcPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}