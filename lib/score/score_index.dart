import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/score_product_model.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/score/score_order.dart';
import 'package:shop/score/score_order_check.dart';
import 'package:shop/score/score_change.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/token.dart';

class ScoreIndex extends StatefulWidget {
  @override
  _ScoreIndexState createState() => _ScoreIndexState();
}

class _ScoreIndexState extends State<ScoreIndex> {

  List<Item> _items = [];
  int _page = 0;
  bool _hasMore = true;
  int _category;
  bool _isLoading = true;
  int _score = 0;

  ScrollController _controller = new ScrollController();

  @override
  initState(){
    super.initState();
    getUserBaseInfo();
    fetchNextPage();
    _controller.addListener((){
      if (_controller.position.pixels ==
          _controller.position.maxScrollExtent) {
        fetchNextPage();
      }
    });
  }
  
  getUserBaseInfo()async{
    String token = await getToken();
    if(token.isEmpty){
      return;
    }
    http.get(api_prefix + '/user/info',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      UserModel _userModel = UserModel.fromJson(json.decode(res.body));
      setState(() {
        _score = _userModel.data.score;
      });
    });
  }

  fetchNextPage(){
    if(!_hasMore){
      showToast(context, '没有更多了~');
      return;
    }
    setState(() {
      _isLoading = true;
      _page++;
    });
    String url;
    if(_category != null){
      url = api_prefix + '/score-products?page=$_page&category=$_category';
    }else{
      url = api_prefix + '/score-products?page=$_page';
    }
    http.get(url).then((res){
      ScoreProductModel _scoreProductModel = ScoreProductModel.fromJson(json.decode(res.body));
      if(_scoreProductModel.data.perPage > _scoreProductModel.data.data.length){
        setState(() {
          _isLoading = false;
          _hasMore = false;
          _items.addAll(_scoreProductModel.data.data);
        });
      }else{
        setState(() {
          _isLoading = false;
          _hasMore = true;
          _items.addAll(_scoreProductModel.data.data);
        });
      }
    });
  }

  Widget _buildItem(Item item){
    return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(item.imageCover,
                  height: 130,width: 160,),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Text(item.title,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),softWrap: true,maxLines: 2,overflow: TextOverflow.ellipsis,),
                      ),
                      Row(
                        children: item.features.split(',').map((str){
                          return Container(
                            margin: EdgeInsets.all(2),
                            child: Text(
                              str,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1)),
                            padding: EdgeInsets.all(1),
                          );
                        }).toList(),
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('已兑：',style: TextStyle(
                                  color: Colors.grey
                              ),),
                              Text(item.sales.toString(),style: TextStyle(
                                  color: Colors.redAccent
                              ),),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: Row(
                              children: <Widget>[
                                Text('剩余：', style: TextStyle(
                                    color: Colors.grey
                                ),),
                                Text(item.stock.toString(), style: TextStyle(
                                    color: Colors.redAccent
                                ),),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage('images/commons/jdd.png'),
                                  radius: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(item.score.toString(),style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.redAccent
                                  ),),
                                )
                              ],
                            ),
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: RaisedButton(
                              child: Text('立即兑换'),
                              textColor: Colors.white,
                              color: Colors.redAccent.withOpacity(0.8),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return ScoreOrderCheck(item: item,);
                                }));
                              },
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
    );
  }

  Future<void> _onRefresh()async{
    setState(() {
      _page = 0;
      _category = null;
      _hasMore = true;
      _items = [];
    });
    fetchNextPage();
    getUserBaseInfo();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Container(
        child: ListView(
          controller: _controller,
          children: <Widget>[
            Container(
                height: 150,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFFE6C599), Color(0xFFD2AC7C)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 20,
                          child: Text(
                            _score.toString(),
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 20,
                          child: Text(
                            '积分',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              child: Text('积分变化',style: TextStyle(
                                  fontSize: 16
                              ),),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return ScoreChange();
                                }));
                              },
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              child: Text('兑换记录',style: TextStyle(
                                  fontSize: 16
                              ),),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return ScoreOrder();
                                }));
                              },
                            )
                          ],
                        )
                    ),
                  ],
                )),
            commonDivider(),
            Container(
              height: 100,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '实物商城',
                          style:
                          TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '好货多先到先得',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        _page = 0;
                        _category = 1;
                        _hasMore = true;
                        _items = [];
                      });
                      fetchNextPage();
                    },
                  ),
                  CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/commons/express.jpg',
                      )),
                  GestureDetector(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '虚拟商城',
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '话费流量0元兑',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        _page = 0;
                        _category = 2;
                        _hasMore = true;
                        _items = [];
                      });
                      fetchNextPage();
                    },
                  ),
                  CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/commons/cloud.png',
                      )),
                ],
              ),
            ),
            commonDivider(),
            Column(
              children: _items.map((item) => _buildItem(item)).toList(),
            ),
            Offstage(
              offstage: !_isLoading,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RefreshProgressIndicator(),
                    SizedBox(width: 2,),
                    Text('正在加载...')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onRefresh: _onRefresh,
    );
  }
}
