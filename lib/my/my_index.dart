import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/entry_item.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:flutter_badge/flutter_badge.dart';
import 'package:shop/models/badge_model.dart';
import 'package:shop/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/my/profile/profile.dart';

import 'order/order_list.dart';

class MyIndex extends StatefulWidget {
  @override
  _MyIndexState createState() => _MyIndexState();
}

class _MyIndexState extends State<MyIndex> {

  Widget _buildOrderItem(IconData icon, String text,int num) {
    return Badge(
        number: num,
        visible: num != 0,
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
              Icon(icon, color: Colors.redAccent,),
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
  bool _isLoading = true;
  num waitPays = 0;
  num waitReceives = 0;
  num waitComments = 0;
  File _image;

  @override
  void initState() {
    super.initState();
    _getBaseInfo();
  }

  _getBaseInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    if (token.isNotEmpty){
      //请求个人信息
      http.get(api_prefix + '/user/info',headers: {
        'Authorization':'Bearer ' + token
      }).then((res){
        print(res.body);
        setState(() {
          _userModel = UserModel.fromJson(json.decode(res.body));
          _isLogined = true;
          _isLoading = false;
        });
      });

      //请求badge
      http.get(api_prefix + '/order/badge',headers: {
        'Authorization':'Bearer ' + token
      }).then((res){
        setState(() {
          BadgeModel _badgeModel = BadgeModel.fromJson(json.decode(res.body));
          waitPays = _badgeModel.data.waitPays;
          waitReceives = _badgeModel.data.waitReceives;
          waitComments = _badgeModel.data.waitComments;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _isLogined ?
        Container(
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          height: 80.0,
          child: TouchCallback(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return Profile(userModel: _userModel,);
              })).then((res)async{
                if(res == 'refresh'){
                  _getBaseInfo();
                }
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12.0,right: 15.0),
                  child: _image != null ? Image.file(_image,width: 70.0,height: 70.0,) : Image.network(_userModel.data.avatar,width: 70.0,height: 70.0,),
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
                  child: _image != null ? Image.file(_image,width: 24.0,height: 24.0,) : Image.network(_userModel.data.avatar,width: 24.0,height: 24.0,),
                ),
              ],
            ),
          ),
        ) :
            !_isLoading ?
        Container(
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          height: 80.0,
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                child: Text('登录'),
                borderSide: BorderSide(color: Colors.redAccent),
                onPressed: (){
                  Navigator.of(context).pushNamed('/login');
                },
              ),
              OutlineButton(
                child: Text('注册'),
                borderSide: BorderSide(color: Colors.redAccent),
                onPressed: (){
                  Navigator.of(context).pushNamed('/register');
                },
              ),
            ],
          ),
        ) : Container(
              margin: EdgeInsets.only(top: 20.0),
              color: Colors.white,
              height: 80.0,
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[

                ],
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
                child: _buildOrderItem(Icons.menu,'全部订单',0),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return OrderList(initIndex: 0,);
                      })
                  );
                },
              ),
              TouchCallback(
                child: _buildOrderItem(Icons.payment, '待付款',waitPays),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return OrderList(initIndex: 1,);
                      })
                  );
                },
              ),
              TouchCallback(
                child: _buildOrderItem(Icons.flight, '待收货',waitReceives),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return OrderList(initIndex: 3,);
                      })
                  );
                },
              ),
              TouchCallback(
                child: _buildOrderItem(Icons.insert_comment, '待评价',waitComments),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return OrderList(initIndex: 4,);
                      })
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              EntryItem(
                icon: Icon(Icons.message,color: Colors.lime,),
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
                icon: Icon(Icons.shopping_cart,color: Colors.purpleAccent,),
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
                icon: Icon(Icons.recent_actors,color: Colors.blue,),
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
                icon: Icon(Icons.data_usage,color: Colors.lightGreen,),
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
                icon: Icon(Icons.help,color: Colors.cyan,),
                title: '关于小店',
                onPressed: (){
                  Navigator.of(context).pushNamed('/about');
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
