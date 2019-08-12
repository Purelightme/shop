import 'package:flutter/material.dart';

class ScoreRecord extends StatefulWidget {
  @override
  _ScoreRecordState createState() => _ScoreRecordState();
}

class _ScoreRecordState extends State<ScoreRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('积分变化'),
      ),
      body: Container(
        child: Center(
          child: Text('积分变化记录'),
        ),
      ),
    );
  }
}
