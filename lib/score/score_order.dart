import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/score_order_model.dart';
import 'package:shop/utils/token.dart';

class ScoreOrder extends StatefulWidget {
  @override
  _ScoreOrderState createState() => _ScoreOrderState();
}

class _ScoreOrderState extends State<ScoreOrder> {

  List<Item> _items = [];

  int _status;
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
    if(_status != null){
      url = api_prefix + '/score-orders?status=$_status&page=$_page';
    }else{
      url = api_prefix + '/score-orders?page=$_page';
    }
    http.get(url,headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      ScoreOrderModel _scoreOrderModel = ScoreOrderModel.fromJson(json.decode(res.body));
      if(_scoreOrderModel.data.perPage > _scoreOrderModel.data.data.length){
        setState(() {
          _isLoading = false;
          _hasMore = false;
          _items.addAll(_scoreOrderModel.data.data);
        });
      }else{
        setState(() {
          _isLoading = false;
          _hasMore = true;
          _items.addAll(_scoreOrderModel.data.data);
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
                    child: Text(item.scoreProduct.title,style: TextStyle(
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
                      '-' + item.scoreProduct.score.toString(),
                    style: TextStyle(
                      color: item.status == 1 ? Colors.blueAccent :
                          item.status == 2 ? Colors.redAccent :
                              Colors.green
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(item.statusDesc,style: TextStyle(
                      color: item.status == 1 ? Colors.blueAccent :
                      item.status == 2 ? Colors.redAccent :
                      Colors.green
                  ),),
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
        title: Text('兑换记录'),
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
                      _status = null;
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
                        color: _status == null ? Color(0xFFD2AC7C) : Color(0xFFE6C599),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      _status = 1;
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
                      child: Text('处理中'),
                    ),
                    decoration: BoxDecoration(
                        color: _status == 1 ? Color(0xFFD2AC7C) : Color(0xFFE6C599),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      _status = 2;
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
                      child: Text('兑换失败'),
                    ),
                    decoration: BoxDecoration(
                        color: _status == 2 ? Color(0xFFD2AC7C) : Color(0xFFE6C599),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      _status = 3;
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
                      child: Text('兑换成功'),
                    ),
                    decoration: BoxDecoration(
                        color: _status == 3 ? Color(0xFFD2AC7C) : Color(0xFFE6C599),
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
        ),
    );
  }
}
