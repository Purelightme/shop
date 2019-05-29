import 'package:flutter/material.dart';

class VideoCoverImage extends StatelessWidget {

  VideoCoverImage({this.url});

  final String url;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Image.network(url,
            height: 200,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            left: MediaQuery.of(context).size.width/2-20,
            top: 80,
            child: Icon(Icons.play_circle_outline,size: 50,color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
