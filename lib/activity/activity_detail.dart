import 'package:flutter/material.dart';

class ActivityDetail extends StatefulWidget {
  @override
  _ActivityDetailState createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('活动详情'),
      ),
      body: Container(
        child: Center(
          child: Text('活动详情'),
        ),
      ),
    );
  }
}
