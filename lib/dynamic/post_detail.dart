import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文章详情'),
      ),
      body: Container(
        child: Center(
          child: Text('未实现'),
        ),
      ),
    );
  }
}
