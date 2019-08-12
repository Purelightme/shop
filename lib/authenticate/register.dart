import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/user_model.dart';

import '../main.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  GlobalKey<FormState> registerKey = new GlobalKey<FormState>();

  String email;
  String code;
  String password;
  String passwordConfirmation;
  int waitSeconds = 0;
  String waitText = '获取验证码';
  Timer countDownTimer;
  bool isSendBtnDisabled = false;

  CommonResModel _commonResModel;

  @override
  void dispose(){
    countDownTimer?.cancel();
    countDownTimer = null;
    super.dispose();
  }

  _register(){
    var registerForm = registerKey.currentState;
    if (registerForm.validate()){
      registerForm.save();
      http.post(api_prefix + '/user/auth/register',body: {
        'email':email,
        'code':code,
        'password':password,
        'password_confirmation':passwordConfirmation
      }).then((res)async{
        UserModel _userModel = UserModel.fromJson(json.decode(res.body));
        if (_userModel.errcode != 0){
          showToast(context, _userModel.errmsg);
        }else{
          showToast(context, _userModel.errmsg);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', _userModel.data.token);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return MyApp();
          }));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text('一小店',style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                ),),
              )
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text('忆君心似西江水，日夜东流无歇时',style: TextStyle(
                  fontSize: 10.0
              ),),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: registerKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: '邮箱'
                      ),
                      onSaved: (value){
                        email = value;
                      },
                      onFieldSubmitted: (value){},
                      validator: (value){
                        return value.length == 0 ? '请输入邮箱' : null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: '验证码',
                        helperText: waitText == '获取验证码' ? '点击右边按钮获取验证码' : waitText,
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.email,
                              color: waitSeconds == 0 ? Colors.redAccent : Colors.grey,
                            ),
                            onPressed: (){
                              //发送邮箱验证码
                              registerKey.currentState.save();
                              if (email.length == 0){
                                showToast(context,'请输入邮箱',duration: 3,gravity: 300);
                              }else{
                                if (waitSeconds > 0){
                                  showToast(context,'请等待${60-waitSeconds}s',duration: 3,gravity: 300);
                                  return;
                                }
                                http.post(api_prefix + '/user/auth/register_code',headers: {
                                  'X-Requested-With':'XMLHttpRequest'
                                },body: {
                                  'email':email
                                }).then((res){
                                  print(res.body);
                                  _commonResModel = CommonResModel.fromJson(json.decode(res.body));
                                  if (_commonResModel.errcode != 0){
                                    showToast(context,_commonResModel.errmsg,duration: 3);
                                  }else{
                                    countDownTimer = Timer.periodic(Duration(seconds: 1), (timer){
                                      setState(() {
                                        if (waitSeconds < 60){
                                          waitText = '${60-waitSeconds}秒后可重新获取';
                                          waitSeconds += 1;
                                        }else{
                                          waitText = '重新获取';
                                          waitSeconds = 0;
                                          countDownTimer.cancel();
                                          countDownTimer = null;
                                        }
                                      });
                                    });
                                    showToast(context,'验证码已发送到:$email',duration: 3);
                                  }
                                });
                              }
                            },
                          disabledColor: Colors.grey,
                        )
                      ),
                      onSaved: (value){
                        code = value;
                      },
                      onFieldSubmitted: (value){},
                      validator: (value){
                        return value.length < 4 ? '请输入验证码' : null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: '密码',
                      ),
                      onSaved: (value){
                        password = value;
                      },
                      onFieldSubmitted: (value){},
                      obscureText: true,
                      validator: (value){
                        return value.length < 6 ? '密码最低6位' : null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: '确认密码',
                      ),
                      onSaved: (value){
                        passwordConfirmation = value;
                      },
                      onFieldSubmitted: (value){},
                      obscureText: true,
                      validator: (value){
                        return passwordConfirmation != password ? '两次密码不一致' : null;
                      },
                    ),
                  ],
                )
            ),
          ),
          SizedBox(
            width: 340.0,
            height: 42.0,
            child: RaisedButton(
              color: Color(0xffff1644),
              onPressed: _register,
              child: Text('注册',style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white
              ),),
            ),
          )
        ],
      ),
    );
  }
}
