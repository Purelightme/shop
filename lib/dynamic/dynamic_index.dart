import 'package:flutter/material.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:shop/common/video_cover_image.dart';
import 'package:shop/dynamic/video_detail.dart';

class DynamicIndex extends StatefulWidget {
  @override
  _DynamicIndexState createState() => _DynamicIndexState();
}

Widget _buildVideo(context){
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          child: Text('标题这是：燃烧我的卡路里，拜拜，时隔两年，许嵩又发新歌',style: TextStyle(
              fontSize: 18,
              color: Colors.black
          ),),
        ),
        TouchCallback(
          child: VideoCoverImage(url: 'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg',),
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                return VideoDetail();
              })
            );
          },
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Text('央视一套',style: TextStyle(
              color: Colors.grey.withOpacity(0.8)
          ),),
        )
      ],
    ),
  );
}

Widget _buildPost(){
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 0),
          child: Text('标题这是：燃烧我的卡路里，拜拜，时隔两年，许嵩又发',style: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),),
        ),
        Container(
          height: 100,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            physics: new NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                child: Image.asset('images/banners/xiezi.jpeg',),
              ),
              Container(
                child: Image.asset('images/banners/xiezi.jpeg',),
              ),
              Container(
                child: Image.asset('images/banners/xiezi.jpeg',),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Text('央视一套',style: TextStyle(
            color: Colors.grey.withOpacity(0.8)
          ),),
        )
      ],
    ),
  );
}


class _DynamicIndexState extends State<DynamicIndex> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            _buildPost(),
            Divider(),
            _buildPost(),
            Divider(),
            _buildPost(),
            Divider(),
            _buildPost(),
            Divider(),
            _buildVideo(context),
          ],
        )
    );
  }
}
