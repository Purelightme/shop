import 'package:flutter/material.dart';

class SelectedCircle extends CustomPainter{

  SelectedCircle({this.center,this.radius});

  final Offset center;
  double radius;

  Paint _paint = Paint()
    ..color = Colors.green
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(center, radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}