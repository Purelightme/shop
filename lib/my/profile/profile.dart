import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:flutter/services.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人信息'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: (){
              showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(500.0, 80.0, 0, 0),
                  items: <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                '退出登录',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    )
                  ]
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          TouchCallback(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('头像'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: _image == null ?
                        AssetImage('images/banners/xiezi.jpeg') :
                        FileImage(_image),
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  )
                ],
              ),
            ),
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context){
                    return new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Icon(Icons.photo_camera),
                          title: new Text("拍照"),
                          onTap: () async {
                            _image = await ImagePickerSaver.pickImage(
                                source: ImageSource.camera
                            );
                            setState(() {
                              
                            });
                            Navigator.pop(context);
                          },
                        ),
                        new ListTile(
                          leading: new Icon(Icons.photo_library),
                          title: new Text("相册"),
                          onTap: () async {
                            _image = await ImagePickerSaver.pickImage(
                                source: ImageSource.gallery
                            );
                            setState(() {
                              
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }
              );
            },
          ),
          Divider(),
          TouchCallback(
            child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('昵称'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Purelightme'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    )
                  ],
                )
            ),
            onPressed: (){
              Navigator.of(context).pushNamed('/update_nickname');
            },
          ),
          Divider(),
          TouchCallback(
            child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('邮箱'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('591592159@qq.com'),
//                        Icon(Icons.arrow_forward_ios)
                      ],
                    )
                  ],
                )
            ),
            onPressed: (){
              showToast(context,'邮箱暂不支持修改哦');
//              Navigator.of(context).pushNamed('/update_email');
            },
          ),
          Divider(),
        ],
      )
    );
  }
}
