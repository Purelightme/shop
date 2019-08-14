import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/score_change_model.dart';
import 'package:shop/utils/token.dart';

class ScoreChange extends StatefulWidget {
  @override
  _ScoreChangeState createState() => _ScoreChangeState();
}

class _ScoreChangeState extends State<ScoreChange> {

  List<Item> _items = [];

  int _isDecrement;
  int _page = 0;
  bool _hasMore = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNextPage();
  }

  fetchNextPage()async{
    if(!_hasMore){
      showToast(context,'没有更多啦~');
      return;
    }
    setState(() {
      _isLoading = true;
      _page++;
    });
    String token = await getToken();
    if(token.isEmpty){
      showToast(context, '请先登录');
      return;
    }
    String url;
    if(_isDecrement != null){
      url = api_prefix + '/score-changes?is_decrement=$_isDecrement&page=$_page';
    }else{
      url = api_prefix + '/score-changes?page=$_page';
    }
    http.get(url,headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      ScoreChangeModel _scoreChangeModel = ScoreChangeModel.fromJson(json.decode(res.body));
      if(_scoreChangeModel.data.perPage > _scoreChangeModel.data.data.length){
        setState(() {
          _isLoading = false;
          _hasMore = false;
          _items.addAll(_scoreChangeModel.data.data);
        });
      }else{
        setState(() {
          _isLoading = false;
          _hasMore = true;
          _items.addAll(_scoreChangeModel.data.data);
        });
      }
    });
  }

  Widget _buildItem(Item item){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(item.title,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                    ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(item.createdAt,style: TextStyle(
                        color: Colors.grey
                    ),),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    item.isDecrement == 0 ?
                      '+' + item.score.toString() :
                        '-' + item.score.toString(),style: TextStyle(
                    color: item.isDecrement == 0 ? Colors.green :
                        Colors.redAccent
                  ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(item.type),
                )
              ],
            ),
          ],
        ),
        Divider()

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('积分变化'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: (){
                  setState(() {
                    _isDecrement = null;
                    _hasMore = true;
                    _page = 0;
                    _items = [];
                  });
                  fetchNextPage();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text('全部'),
                  ),
                  decoration: BoxDecoration(
                      color: _isDecrement == null ? Color(0xFFD2AC7C) : Color(0xFFE6C599),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _isDecrement = 0;
                    _hasMore = true;
                    _page = 0;
                    _items = [];
                  });
                  fetchNextPage();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text('收入'),
                  ),
                  decoration: BoxDecoration(
                      color: _isDecrement == 0 ? Color(0xFFD2AC7C) : Color(0xFFE6C599),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _isDecrement = 1;
                    _hasMore = true;
                    _page = 0;
                    _items = [];
                  });
                  fetchNextPage();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text('支出'),
                  ),
                  decoration: BoxDecoration(
                      color: _isDecrement == 1 ? Color(0xFFD2AC7C) : Color(0xFFE6C599),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ..._items.map((item) => _buildItem(item)).toList(),
          Offstage(
            offstage: !_isLoading,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RefreshProgressIndicator(),
                  SizedBox(width: 2,),
                  Text('正在加载...')
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
