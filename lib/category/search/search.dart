import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/api/api.dart';
import 'package:shop/category/product/product_list.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/hot_search_model.dart' as hot_search;
import 'package:shop/models/search_history_model.dart' as search_history;
import 'package:shop/utils/token.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _controller = new TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  hot_search.HotSearchModel _hotSearchModel;
  search_history.SearchHistoryModel _searchHistoryModel;

  @override
  void initState() {
    super.initState();
    _getHotSearch();
    _getSearchHistory();
  }

  _getHotSearch(){
    http.get(api_prefix + '/hot-searches').then((res){
      setState(() {
        _hotSearchModel = hot_search.HotSearchModel.fromJson(json.decode(res.body));
      });
    });
  }

  _getSearchHistory()async{
    String token = await getToken();
    if (token.isEmpty){
      return;
    }
    http.get(api_prefix + '/search-histories',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      setState(() {
        _searchHistoryModel = search_history.SearchHistoryModel.fromJson(json.decode(res.body));
      });
    });
  }

  //清空搜索历史
  _empty(){
    showDialog(
        context: context,
        barrierDismissible: true,
        child: AlertDialog(
          title: Text('清空'),
          content: Text('亲，确定清空搜索历史吗？'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: (){
                Navigator.of(context).pop('cancel');
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: (){
                Navigator.of(context).pop('ok');
              },
            )
          ],
        )
    ).then((value)async{
      if(value == 'ok'){
        String token = await getToken();
        http.delete(api_prefix + '/search-history/empty',headers: {
          'Authorization':'Bearer $token'
        }).then((res){
          CommonResModel _CommonResModel = CommonResModel.fromJson(json.decode(res.body));
          if(_CommonResModel.errcode != 0){
            showToast(context,_CommonResModel.errmsg);
          }else{
            setState(() {
              _searchHistoryModel.data.clear();
            });
            showToast(context,_CommonResModel.errmsg);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.redAccent,
          leading: BackButton(),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text('搜索'),
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return ProductList(keyword: _controller.text,);
                }));
              },
            )
          ],
          elevation: 0,
          titleSpacing: 0,
          title: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.search,color: Color.fromRGBO(51, 51, 51, 1),size: 20,),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return ProductList(keyword: value,);
                      }));
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: '搜一搜',
                        hintStyle: TextStyle(fontSize: 14),
                        border: InputBorder.none
                    ),
                  ),
                )
              ],
            ),
          )
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.withOpacity(0.2),
              padding: EdgeInsets.all(10),
              child: Text('热门搜索'),
            ),
        _hotSearchModel != null ?
        Container(
              padding: EdgeInsets.all(10),
              child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _hotSearchModel.data.map<Widget>((data){
                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Text(data.keyword,style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6)
                        ),),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return ProductList(keyword: data.keyword,);
                        }));
                      },
                    );
                  }).toList()
              ),
            ) :
        Container(
          child: Center(
            child: RefreshProgressIndicator(),
          ),
        ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.withOpacity(0.2),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('最近搜索'),
                  GestureDetector(
                    child: Icon(Icons.delete_outline,color: Colors.deepOrangeAccent,),
                    onTap: (){
                      _empty();
                    },
                  )
                ],
              ),
            ),
            _searchHistoryModel != null ?
            Container(
              padding: EdgeInsets.all(10),
              child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _searchHistoryModel.data.map<Widget>((keyword){
                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Text(keyword,style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.6)
                        ),),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return ProductList(keyword: keyword,);
                        }));
                      },
                    );
                  }).toList()
              ),
            ) :
            Container(
              child: Center(
                child: RefreshProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
