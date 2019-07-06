import 'package:flutter/material.dart';

class Arc extends CustomPainter{

  Arc({this.center,this.radius});

  final Offset center;
  double radius;

  Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 5
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        0, 360, false, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}