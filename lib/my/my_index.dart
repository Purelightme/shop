import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/entry_item.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:flutter_badge/flutter_badge.dart';
import 'package:shop/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'order/order_list.dart';

class MyIndex extends StatefulWidget {
  @override
  _MyIndexState createState() => _MyIndexState();
}

class _MyIndexState extends State<MyIndex> {

  Widget _buildOrderItem(IconData icon, String text) {
    return Badge(
        number: 1,
        backgroundColor: Colors.white,
        offsetX: -8,
        offsetY: -8,
        textStyle: TextStyle(
          color: Colors.redAccent
        ),
        borderColor: Colors.red,
        borderWidth: 1,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: Colors.black54,),
              Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Text(text, style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                  ),)
              )
            ]
        ));
  }

  UserModel _userModel;
  bool _isLogined = false;

  @override
  void initState() {
    super.initState();
    _getBaseInfo();
  }

  _getBaseInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? '';
    if (token.isNotEmpty){
      http.get(api_prefix + '/user/info',headers: {
        'Authorization':'Bearer ' + token
      }).then((res){
        setState(() {
          _userModel = UserModel.fromJson(json.decode(res.body));
          _isLogined = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLogined ? ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          height: 80.0,
          child: TouchCallback(
            onPressed: (){
              Navigator.of(context).pushNamed('/profile');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12.0,right: 15.0),
                  child: Image.asset('images/banners/clothes.jpeg',width: 70.0,height: 70.0,),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(_userModel.data.name,style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF353535)
                      ),),
                      Text('你是小店第${_userModel.data.registerNumber}位顾客',style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFa9a9a9)
                      ),)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12.0,right: 15.0),
                  child: Image.asset('images/banners/clothes.jpeg',width: 24.0,height: 24.0,),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 100.0,
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TouchCallback(
                child: _buildOrderItem(Icons.menu,'全部订单'),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return OrderList();
                      })
                  );
                },
              ),
              _buildOrderItem(Icons.payment, '待付款'),
              _buildOrderItem(Icons.flight, '待收货'),
              _buildOrderItem(Icons.insert_comment, '待评价'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              EntryItem(
                icon: Icon(Icons.message),
                title: '我的消息',
                onPressed: (){
                  Navigator.of(context).pushNamed('/message');
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Divider(
                  height: 0.5,
                  color: Color(0xFFd9d9d9),
                ),
              ),
              EntryItem(
                icon: Icon(Icons.shopping_cart),
                title: '购物车',
                onPressed: (){
                  Navigator.of(context).pushNamed('/cart');
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Divider(
                  height: 0.5,
                  color: Color(0xFFd9d9d9),
                ),
              ),
              EntryItem(
                icon: Icon(Icons.recent_actors),
                title: '收货地址',
                onPressed: (){
                  Navigator.of(context).pushNamed('/receive_address');
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Divider(
                  height: 0.5,
                  color: Color(0xFFd9d9d9),
                ),
              ),
              EntryItem(
                icon: Icon(Icons.data_usage),
                title: '购物流程',
                onPressed: (){
                  Navigator.of(context).pushNamed('/usage');
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Divider(
                  height: 0.5,
                  color: Color(0xFFd9d9d9),
                ),
              ),
              EntryItem(
                icon: Icon(Icons.help),
                title: '关于小店',
                onPressed: (){
                  Navigator.of(context).pushNamed('/about');
                },
              )
            ],
          ),
        ),
      ],
    ) : Container(
      child: Center(
        child: Text('未登录'),
      ),
    );
  }
}
