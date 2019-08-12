import 'package:flutter/material.dart';

class ScoreOrderCheck extends StatefulWidget {
  @override
  _ScoreOrderCheckState createState() => _ScoreOrderCheckState();
}

class _ScoreOrderCheckState extends State<ScoreOrderCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('积分兑换订单确认页'),
        ),
      ),
    );
  }
}
