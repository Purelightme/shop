import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/message_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/token.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  List<Item> _items = [];
  int _page = 0;
  bool _hasMore = true;

  ScrollController _scrollController = new ScrollController();


  @override
  initState(){
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
        print('我监听到底部了!');
      }
    });
    _loadMore();
    super.initState();
  }

  _loadMore()async{
    if(_hasMore == false){
      showToast(context, '没有更多消息了');
      return;
    }
    String token = await getToken();
    http.get(api_prefix+'/messages?page=${_page+1}',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      print(res.body);
      MessageModel _messageModel = MessageModel.fromJson(json.decode(res.body));
      if(_messageModel.errcode != 0){
        showToast(context,_messageModel.errmsg);
      }else{
        if(_messageModel.data.data.length < 10){
          setState(() {
            _hasMore = false;
            _items.addAll(_messageModel.data.data);
            _page = _page + 1;
          });
        }else{
          setState(() {
            _items.addAll(_messageModel.data.data);
            _page = _page + 1;
          });
        }
      }
    });
  }


  _read(int index)async{
    String token = await getToken();
    http.post(api_prefix+'/messages/${_items[index].id}/read',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
      if(_commonResModel.errcode != 0){
        showToast(context, _commonResModel.errmsg);
      }else{
        setState(() {
          _items[index].isReaded = 1;
        });
      }
    });
  }


  Widget _buildMessageItem(int index){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(_items[index].type,style: TextStyle(
                      color: _items[index].isReaded == 1 ? Colors.grey : Colors.black
                  ),),
                ),
                Container(
                  child: Text(_items[index].createdAt,style: TextStyle(
                      color: _items[index].isReaded == 1 ? Colors.grey : Colors.black
                  ),),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(_items[index].content,style: TextStyle(
                  color: _items[index].isReaded == 1 ? Colors.grey : Colors.black
              ),),
            )
          ],
        ),
      ),
      onTap: (){
        _read(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的消息'),
      ),
      body: Container(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _items.length,
          itemBuilder: (BuildContext context,index){
            return Column(
              children: <Widget>[
                _buildMessageItem(index),
                Divider()
              ],
            );
          },
        )
      ),
    );
  }
}
