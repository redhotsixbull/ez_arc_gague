import 'package:flutter/material.dart';
import 'package:ez_gauge/src/arc_ez_gague.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GradientArcPainterDemo(value: 0.8,startColor: Colors.red,endColor: Colors.green,width: 10,startAngle: 1.3, endAngle: 1.6,backgroundColor: Colors.yellow,)
        ),
      ),
    );
  }
}
