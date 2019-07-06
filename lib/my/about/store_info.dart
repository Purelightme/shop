import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/save_image.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:shop/models/pictures_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_drag_scale/flutter_drag_scale.dart';

class StoreInfo extends StatefulWidget {
  @override
  _StoreInfoState createState() => _StoreInfoState();
}

class _StoreInfoState extends State<StoreInfo> {

  List<Data> _pictures = [];

  @override
  void initState() {
    http.get(api_prefix+'/pictures').then((res){
      setState(() {
        _pictures = PicturesModel.fromJson(json.decode(res.body)).data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('店长信息'),
      ),
      body: _pictures.length == 0 ? Center(
        child: RefreshProgressIndicator(),
      ) : Center(
        child: Container(
          child: PageView(
            children: _pictures.map((Data data){
              return TouchCallback(
                  child: DragScaleContainer(
                    doubleTapStillScale: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(data.image),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(data.title),
                        )
                      ],
                    ),
                  ),
                  onLongPressed: () {
                    saveNetworkImage(context, data.image);
                  }
              );
            }).toList()
          ),
        ),
      ),
    );
  }
}
