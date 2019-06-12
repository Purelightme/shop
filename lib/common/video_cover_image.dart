import 'package:flutter/material.dart';

class VideoCoverImage extends StatelessWidget {

  VideoCoverImage({this.url});

  final String url;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(url),fit: BoxFit.fitWidth)
      ),
      child: Center(
        child: Icon(Icons.play_circle_outline,size: 50,color: Colors.white,),
      ),
    );
  }
}
