import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/my/profile/update_nickname.dart';
import 'package:http/http.dart' as http;


class Profile extends StatefulWidget {

  Profile({@required this.userModel});

  UserModel userModel;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  File _image;
  bool _isLoading = false;

  _updateAvatar(image)async{
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    FormData formData = new FormData.from({
      "avatar": new UploadFileInfo(new File(path), name,
          contentType: ContentType.parse("image/$suffix"))
    });

    Dio dio = new Dio();
    Options options = Options(headers: {
      'Authorization':'Bearer ' + token
    });
    dio.post<String>(api_prefix + '/user/update', data: formData,options: options).then((res){
      setState(() {
        _isLoading = false;
      });
      CommonResModel commonResModel = CommonResModel.fromJson(json.decode(res.data));
      if (commonResModel.errcode != 0){
        showToast(context, commonResModel.errmsg);
      }else{
        setState(() {
          _image = image;
        });
        Navigator.pop(context,'refresh');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                            NetworkImage(widget.userModel.data.avatar) :
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
                                File image = await ImagePickerSaver.pickImage(
                                    source: ImageSource.camera
                                );
                                _updateAvatar(image);
                                Navigator.pop(context);
                              },
                            ),
                            new ListTile(
                              leading: new Icon(Icons.photo_library),
                              title: new Text("相册"),
                              onTap: () async {
                                File image = await ImagePickerSaver.pickImage(
                                    source: ImageSource.gallery
                                );
                                _updateAvatar(image);
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
                            Text(widget.userModel.data.name),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        )
                      ],
                    )
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return UpdateNickname(origin: widget.userModel.data.name,);
                  }));
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
                            Text(widget.userModel.data.email),
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
              _isLoading ? Container(
                child: Center(
                  child: RefreshProgressIndicator(),
                ),
              ) : Container()
            ],
          )
      ),
      onWillPop: (){
        return new Future.value(true);
      },
    );
  }
}
