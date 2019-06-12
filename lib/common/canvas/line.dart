import 'package:flutter/material.dart';

class Line extends CustomPainter{

  Line({this.start,this.end});

  final Offset start;
  final Offset end;

  Paint _paint = Paint()
    ..color = Colors.grey
  ..strokeCap = StrokeCap.square
  ..isAntiAlias = true
  ..strokeWidth = 2
  ..style = PaintingStyle.stroke;
  
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(start, end, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
  
}