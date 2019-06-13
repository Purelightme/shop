import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/common_res_model.dart';

class UpdateNickname extends StatefulWidget {

  UpdateNickname({@required this.origin});

  String origin;

  @override
  _UpdateNicknameState createState() => _UpdateNicknameState();
}

class _UpdateNicknameState extends State<UpdateNickname> {

  final TextEditingController _controller = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改昵称'),
        centerTitle: true,
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new TextField(
          autofocus: true,
          controller: _controller,
          decoration: new InputDecoration(
            hintText: widget.origin,
          ),
          maxLength: 10,
        ),
        Container(
          width: 10,
          height: 10,
        ),
        new SizedBox(
          width: 340,
          height: 42,
          child: RaisedButton(
            onPressed: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String token = prefs.getString('token') ?? '';
              http.post(api_prefix + '/user/update',headers: {
                'Authorization':'Bearer ' + token
              },body: {
                'name': _controller.text
              }).then((res){
                CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
                if (_commonResModel.errcode != 0){
                  showToast(context,_commonResModel.errmsg);
                }else{
                  Navigator.of(context).pop();
                  //todo 跳转
                }
              });
            },
            color: Colors.redAccent,
            child: Text('确定',style: TextStyle(
                fontSize: 18,
                color: Colors.white
            ),),
          ),
        ),
      ],
    )
    );
  }
}
