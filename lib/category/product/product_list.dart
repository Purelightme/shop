import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop/api/api.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:shop/models/product_list_model.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {

  ProductList({this.isAutoFocus});

  bool isAutoFocus;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  TextEditingController _controller = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  List<int> items = [0,1,2,3,4,5,6,7,8,9];

  ProductListModel _productListModel;
  bool _isLoading = true;

  Future _addMoreData()async{
    Future.delayed(Duration(microseconds: 1),(){
      setState(() {
        items.addAll([10,11,12,13,14,15,16,17,18,19]);
      });
    });
  }

  @override
  void initState() {
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _addMoreData();
        print('我监听到底部了!');
      }
    });
    super.initState();
    http.get(api_prefix + '/products').then((res){
      setState(() {
        _isLoading = false;
        _productListModel = ProductListModel.fromJson(json.decode(res.body));
      });
    });
  }

  Widget _buildTop() {
    return Container(
        height: 40,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text('综合'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('销量'),
            ),
            Container(
//                        padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('价格'),
                  ),
                  Container(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.arrow_drop_up, size: 20,),
                        Icon(Icons.arrow_drop_down, size: 20,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('分类'),
            ),
          ],
        ),
      );
  }

  Widget _buildProductItem_bak(int index){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 1
        ),
        borderRadius: BorderRadius.all(Radius.circular(2))
      ),
        child: Column(
          children: <Widget>[
            Image.asset('images/banners/watch.jpeg',fit: BoxFit.fitWidth,),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('标题这是标题夏季潮流手表小天才电话手表'),
            ),
            Divider(indent: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('\$9.99',style: TextStyle(
                      color: Colors.redAccent
                  ),),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 30,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: <Widget>[
                            Container(
                              child: CircleAvatar(
                                backgroundImage: AssetImage('images/banners/xiezi.jpeg'),
                                radius: 10,
                              ),
                            ),
                            Positioned(
                              left: 10,
                              child: Container(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('images/banners/xiezi.jpeg'),
                                  radius: 10,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text('26人下单'),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10*index.toDouble(),
            )
          ],
        )
    );
  }

  Widget _buildProductItem(int index){
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.white,
                width: 1
            ),
            borderRadius: BorderRadius.all(Radius.circular(2))
        ),
        child: Column(
          children: <Widget>[
            Image.network(_productListModel.data.data[index].imageCover,fit: BoxFit.fitWidth,),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(_productListModel.data.data[index].shortTitle),
            ),
            Divider(indent: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('\￥${_productListModel.data.data[index].price}',style: TextStyle(
                      color: Colors.redAccent
                  ),),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _productListModel.data.data[index].sellingPoint.split(',').map((str) => Container(
                      margin: EdgeInsets.all(1),
                      child: Text(str,style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 10
                      ),),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.redAccent,
                              width: 1
                          )
                      ),
                      padding: EdgeInsets.all(1),
                    )).toList()
                  ),
                )
              ],
            )
          ],
        )
    );
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
                onTap: () {
                  Navigator.of(context).pushNamed('/product_detail');
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
                  Icon(Icons.search, color: Color.fromRGBO(51, 51, 51, 1),
                    size: 20,),
                  Expanded(
                    child: TextField(
                      autofocus: widget.isAutoFocus,
                      controller: _controller,
                      onSubmitted: (value) {
                        print(value);
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
    body: Stack(
      children: <Widget>[
        Positioned(
          left: 0.001,
          child: _buildTop(),
        ),
        _isLoading ? Container() :
        Container(
          margin: EdgeInsets.only(top: 40),
          color: Colors.grey.withOpacity(0.2),
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            primary: false,
            crossAxisCount: 4,
            itemCount: _productListModel.data.data.length,
            itemBuilder: (BuildContext context, int index) => TouchCallback(
              child: _buildProductItem(index),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return ProductDetail(ProductId: _productListModel.data.data[index].id,);
                }));
              },
            ),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.fit(2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ),
      ],
    )
    );
  }
}







