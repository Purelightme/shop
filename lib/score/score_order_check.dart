import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/score_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop/score/score_order.dart';
import 'package:shop/utils/token.dart';

class ScoreOrderCheck extends StatefulWidget {

  ScoreOrderCheck({@required this.item});

  Item item;

  @override
  _ScoreOrderCheckState createState() => _ScoreOrderCheckState();
}

class _ScoreOrderCheckState extends State<ScoreOrderCheck> {

  TextEditingController _controller = new TextEditingController();

  String _deliveryInfo;

  _order()async{
    String token = await getToken();
    if(token.isEmpty){
      showToast(context, '请先登录');
      return;
    }
    setState(() {
      _deliveryInfo = _controller.text;
    });
    http.post(api_prefix + '/score-orders',headers: {
      'Authorization':'Bearer $token',
    },body: {
      'score_product_id': widget.item.id.toString(),
      'delivery_info': _deliveryInfo
    }).then((res){
      CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
      if(_commonResModel.errcode != 0){
        showToast(context, _commonResModel.errmsg);
      }else{
        showToast(context, '申请兑换成功');
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return ScoreOrder();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('兑换确认'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image.network(widget.item.imageCover,width: 100,height: 100,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(widget.item.title),
                    ),
                    Container(
                      child: Text('积分：' + widget.item.score.toString(),style: TextStyle(
                        color: Colors.grey
                      ),),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            height: 10,
            color: Colors.grey.withOpacity(0.2),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 110),
            child: Text('收货信息'),
          ),
          Container(
            color: Colors.blueAccent.withOpacity(0.1),
            margin: EdgeInsets.only(top: 150),
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _deliveryInfo = value;
                });
              },
              autofocus: true,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: '请填写收货信息',
                contentPadding: EdgeInsets.all(0),
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 350),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('1,兑换只需积分，无需任何其他费用。'),
                Text('2,兑换之后等待店主处理，兑换失败的将全额退回积分。'),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    color: Colors.grey.withOpacity(0.2),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16,horizontal: 36),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                            ),
                            child: Text('提交订单',style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),),
                          ),
                          onTap: (){
                            if(_deliveryInfo == null){
                              showToast(context, '请先填写收货信息');
                            }else{
                              _order();
                            }
                          },
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ],
      )
    );
  }
}
