import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  Widget _buildMessageItem(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text('订单消息'),
              ),
              Container(
                child: Text('2019-06-09 17:00:00'),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('您的订单427846854646已发货，可查看最新物流动态'),
          )
        ],
      ),
    );
  }

  Widget _buildMessageItem2(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text('订单消息',style: TextStyle(
                  color: Colors.grey
                ),),
              ),
              Container(
                child: Text('2019-06-09 17:00:00',style: TextStyle(
                    color: Colors.grey
                ),),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('您的订单427846854646已发货，可查看最新物流动态',style: TextStyle(
                color: Colors.grey
            ),),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的消息'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildMessageItem(),
            Divider(),
            _buildMessageItem(),
            Divider(),
            _buildMessageItem2(),
            Divider(),
            _buildMessageItem2(),
            Divider(),
            _buildMessageItem2(),
            Divider(),
            _buildMessageItem2(),
            Divider(),
            _buildMessageItem2(),
            Divider(),
            _buildMessageItem2(),
            Divider(),
            _buildMessageItem2(),
          ],
        )
      ),
    );
  }
}
