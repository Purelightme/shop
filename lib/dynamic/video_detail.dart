import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetail extends StatefulWidget {
  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCommentItem(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    foregroundColor: Colors.redAccent,
                    backgroundImage: AssetImage('images/banners/xiezi.jpeg'),
                  ),
                  Text('昵称'),
                ],
              ),
              Text('2019-05-21 09:04:00')
            ],
          ),
          Text('好搞笑啊，这视频')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
//        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _controller.value.initialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ) : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/banners/xiezi.jpeg'),
                fit: BoxFit.fitWidth
              )
            ),
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('评论'),
          ),
          _buildCommentItem(),
          Divider(),
          _buildCommentItem(),
          Divider(),
          _buildCommentItem(),
          Divider(),
          _buildCommentItem(),
          Divider(),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
