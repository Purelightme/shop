import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/order_list_model.dart';
import 'package:shop/utils/token.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class OrderComment extends StatefulWidget {

  OrderComment({@required this.specificationSnapshot,@required this.orderId});

  List<SpecificationSnapshot> specificationSnapshot;
  int orderId;

  @override
  _OrderCommentState createState() => _OrderCommentState();
}

class _OrderCommentState extends State<OrderComment> {

  double rating = 5;
  String content;
  List images;

  _chooseImages()async{
    List resultList;
    try {
      resultList = await FlutterMultipleImagePicker.pickMultiImages(9, false);
    } on PlatformException catch (e) {
      showToast(context,e.message);
      return;
    }
    setState(() {
      images = new List.from(resultList);
    });
  }

  _renderImages(){
    return images == null ? Container() :
        Wrap(
          spacing: 20,
          runSpacing: 4,
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: images.asMap().map((int index,file){
            return MapEntry(index, Stack(
                  children: <Widget>[
                    Image.file(new File(images[index].toString()),
                      width: 60,
                      height: 60,),
                    Positioned(
                        top: -10,
                        right: -20,
                        child: IconButton(
                          icon: Icon(Icons.close,size: 20,),
                          onPressed: () {
                            setState(() {
                              images.removeAt(index);
                            });
                          },
                        )
                    ),
                  ],
                ),
            );
          }).values.toList(),
        );
  }

  _comment()async{

    print(images);

    Map<String,dynamic> data;
    if(content == null){
      showToast(context, '请填写评论内容');
      return;
    }
    if(images == null || images.length == 0){
      data = {
        '_method':'put',
        'star':rating,
        'content':content,
      };
    }else{
      data = {
        '_method':'put',
        'star':rating,
        'content':content,
        'imgs[]': images.map((file){
          return new UploadFileInfo(new File(file.toString()),'order.png');
        }).toList()
      };
    }

    String token = await getToken();

    FormData formData = new FormData.from(data);

    Dio dio = new Dio();
    Options options = Options(headers: {
      'Authorization':'Bearer ' + token
    });
    dio.post<String>(api_prefix + '/orders/${widget.orderId}/comment', data: formData,options: options).then((res){
      CommonResModel commonResModel = CommonResModel.fromJson(json.decode(res.data));
      if (commonResModel.errcode != 0){
        showToast(context, commonResModel.errmsg);
      }else{
        showToast(context, '评论成功');
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('评论'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ...widget.specificationSnapshot.map((SpecificationSnapshot sp){
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5,left: 10),
                    child: Image.network(sp.imageCover,width: 100,height: 100,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5,left: 10),
                    width: MediaQuery.of(context).size.width - 120,
                    child: Text(sp.longTitle,maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,),
                  )
                ],
              );
            }).toList(),
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                maxLines: null,
                autofocus: true,
                minLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: new InputDecoration(
                  hintText: '评点什么吧~',
                ),
                onChanged: (value){
                  setState(() {
                    content = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_photo_alternate,
                    size: 40,
                    color: Colors.pinkAccent,
                  ),
                  onPressed: () {
                    _chooseImages();
                  },
                )
              ],
            ),
            _renderImages(),
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.store,color: Colors.redAccent.withOpacity(0.8),),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('店铺评分'),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: (v) {
                    setState(() {
                      rating = v;
                    });
                  },
                  starCount: 5,
                  rating: rating,
                  size: 30.0,
                  color: Colors.redAccent,
                  borderColor: Colors.grey,
                  spacing: 5.0
              ),
            ),
            SizedBox(
              width: 340.0,
              height: 42.0,
              child: RaisedButton(
                color: Color(0xffff1644),
                onPressed: (){
                  _comment();
                },
                child: Text('提交评价',style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
