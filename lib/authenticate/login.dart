import 'package:flutter/material.dart';
import 'package:shop/authenticate/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  String email;
  String password;
  bool _isSecureText = true;

  _login(){
    var loginForm = loginKey.currentState;
    if (loginForm.validate()){
      loginForm.save();
      print("email:$email,password:$password");
//      Navigator.of(context).push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(10.0),
            child: Text('一小店',style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Roboto',
            ),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('自从遇见你，就不再打烊',style: TextStyle(
                fontSize: 10.0
            ),),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: loginKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '请输入邮箱'
                    ),
                    onSaved: (value){
                      email = value;
                    },
                    onFieldSubmitted: (value){},
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '请输入密码',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: _isSecureText ? Colors.grey : Colors.redAccent,
                        ),
                        onPressed: (){
                          print(111);
                          setState(() {
                            _isSecureText = !_isSecureText;
                          });
                        },
                      )
                    ),
                    onSaved: (value){
                      password = value;
                    },
                    onFieldSubmitted: (value){},
                    obscureText: _isSecureText,
                    validator: (value){
                      return value.length < 6 ? '密码最低6位' : null;
                    },
                  )
                ],
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text('还没账号?去注册',style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.redAccent,
                  ),),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => new Register()
                  ));
                },
              )
            ],
          ),
          SizedBox(
            width: 340.0,
            height: 42.0,
            child: RaisedButton(
              color: Color(0xffff1644),
              onPressed: _login,
              child: Text('登录',style: TextStyle(
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