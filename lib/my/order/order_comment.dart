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
import 'package:flutter/services.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';



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

      resultList = await PhotoPicker.pickAsset(
        context: context,
        maxSelected: 9,
        pickType: PickType.onlyImage,
        rowCount: 4,
        padding: 3,
        thumbSize: 400
      );
    if(resultList == null){
      //没有选择
      return;
    }
    List<String> imgList = [];
    for(var e in resultList){
      var file = await e.file;
      imgList.add(file.absolute.path);
    }
    setState(() {
      images = new List.from(imgList);
    });
  }

  _renderImages(){
    return images == null ? Container() :
        Wrap(
          spacing: 2,
          runSpacing: 2,
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: images.asMap().map((int index,file){
            return MapEntry(index, Stack(
                  children: <Widget>[
                    GestureDetector(
                      child: Image.file(new File(images[index].toString()),
                        width: 100,
                        height: 100,),
                      onTap: (){
                        setState(() {
                          images.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
            );
          }).values.toList(),
        );
  }

  _comment()async{

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
        color: Colors.grey.withOpacity(0.1),
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
            Row(
              children: <Widget>[
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
                Container(
                  child: Text(rating.toString()),
                )
              ],
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.text_fields,color: Colors.redAccent.withOpacity(0.8),),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('评论内容'),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                maxLines: null,
                autofocus: true,
                minLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: new InputDecoration(
                  hintText: '评点什么吧~',
                  border: InputBorder.none
                ),
                onChanged: (value){
                  setState(() {
                    content = value;
                  });
                },
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.image,color: Colors.redAccent.withOpacity(0.8),),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('图片(可选)'),
                  )
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.image,
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                    Text('点我选择')
                  ],
                ),
              ),
              onTap: (){
                _chooseImages();
              },
            ),
            _renderImages(),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('tips：点击图片可移除',style: TextStyle(
                color: Colors.grey
              ),),
            ),
            SizedBox(
              width: 340.0,
              height: 42.0,
              child: RaisedButton(
                color: Colors.redAccent,
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
