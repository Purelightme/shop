import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/activity_list_model.dart';

import 'activity_detail.dart';

class ActivityIndex extends StatefulWidget {
  @override
  _ActivityIndexState createState() => _ActivityIndexState();
}

class _ActivityIndexState extends State<ActivityIndex> {

  List<Item> _items;
  int _page;
  bool _isLoading = true;

  @override
  initState(){
    super.initState();
    _getFirstPage();
  }

  _getFirstPage()async{
    http.get(api_prefix + '/activities').then((res){
      ActivityListModel activityListModel = ActivityListModel.fromJson(json.decode(res.body));
      if(activityListModel.errcode != 0){
        showToast(context,activityListModel.errmsg);
      }else{
        setState(() {
          _items = activityListModel.data.data;
          _isLoading = false;
        });
      }
    });
  }

  Widget _buildItem(Item item) {
    return GestureDetector(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(item.imageCover),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Baseline(
                              baseline: 16,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(item.title,style: TextStyle(
                                  fontSize: 22
                              ),),
                            ),
                            Baseline(
                              baseline: 16,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(' 共${item.productNum}件商品参与${item.discount}折优惠',style: TextStyle(
                                  fontSize: 12
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          width: 200,
                          child: Text(item.describe,
                            softWrap: true,overflow: TextOverflow.ellipsis,)
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(item.status),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ActivityDetail())
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Container() : Container(
      child: Center(
        child: RefreshIndicator(
          child: ListView(
            children: _items.map((item){
              return _buildItem(item);
            }).toList()
          ),
          onRefresh: (){
            Future.delayed(Duration(seconds: 1)).then((res){
              return [1,2];
            });
          },
        )
      ),
    );
  }
}
