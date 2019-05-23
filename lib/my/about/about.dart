import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于小店'),
      ),
      body: Container(
        child: Center(
          child: Text('你好'),
        ),
      ),
    );
  }
}
