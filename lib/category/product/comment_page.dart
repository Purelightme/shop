import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/image_preview.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/comment_model.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CommentPage extends StatefulWidget {

  CommentPage({@required this.productId});

  int productId;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  List<Item> _items = [];
  int _page = 0;
  bool _hasMore = true;
  ScrollController _scrollController = new ScrollController();


  @override
  initState(){
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadComment();
        print('我监听到底部了!');
      }
    });
    super.initState();
    _loadComment();
  }

  _loadComment()async{
    if(!_hasMore){
      showToast(context, '没有更多啦~~');
      return;
    }
    setState(() {
      _page++;
    });
    http.get(api_prefix + '/comments?page=$_page&product_id=${widget.productId}',headers: {
      'X-Requested-With':'XMLHttpRequest'
    }).then((res){
      print(res.body);
      CommentModel _commentModel = CommentModel.fromJson(json.decode(res.body));
      if(_commentModel.errcode != 0){
        showToast(context,_commentModel.errmsg);
        return;
      }else{
        if(_commentModel.data.data.length < _commentModel.data.perPage){
          setState(() {
            _items.addAll(_commentModel.data.data);
            _hasMore = false;
          });
        }else{
          setState(() {
            _items.addAll(_commentModel.data.data);
            _hasMore = true;
          });
        }
      }
    });
  }

  _buildItem(Item item){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    foregroundColor: Colors.redAccent,
                    backgroundImage: NetworkImage(item.user.avatar),
                  ),
                ),
                Container(
                  child: Text(item.user.name),
                )
              ],
            ),
            SmoothStarRating(
                allowHalfRating: true,
                onRatingChanged: null,
                starCount: 5,
                rating: item.star.toDouble(),
                size: 20.0,
                color: Colors.redAccent,
                borderColor: Colors.grey,
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(item.createdAt +"   "+ item.specificationString,style: TextStyle(
            color: Colors.grey
          ),),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(item.content,style: TextStyle(
            fontSize: 16
          ),),
        ),
        item.imgs.length == 0 ? Container() :
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: item.imgs.asMap().map((index,url){
              return MapEntry(index,GestureDetector(
                child: Image.network(url,width: 100,height: 100,),
                onTap: (){
                  _toPreview(item.imgs,index);
                },
              ));
            }).values.toList(),
          ),
        ),
        Divider(),
      ],
    );
  }

  _toPreview(List<String> images,index){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return ImagePreview(images: images,index: index);
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('评价'),
        centerTitle: true,
      ),
      body: _items.length == 0 ? Container(
        child: Center(
          child: Text('还没有评论~'),
        ),
      ) : ListView.builder(
        controller: _scrollController,
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(_items[index]);
        },
      ),
    );
  }
}
