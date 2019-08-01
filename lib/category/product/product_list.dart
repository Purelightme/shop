import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop/api/api.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/common/smart_drawer.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:shop/models/category_model.dart' as category;
import 'package:shop/models/product_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/token.dart';

class ProductList extends StatefulWidget {
  ProductList({this.isAutoFocus = false, this.keyword, this.categoryId});

  bool isAutoFocus;
  String keyword;
  int categoryId;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController _controller;

  ScrollController _scrollController = new ScrollController();

  List<Iterm> _iterms = [];
  bool _isLoading = true;
  String _order_field = 'created_at';
  String _order_direction = 'desc';
  int _category_id;
  int _page = 0;
  bool _hasMore = true;
  category.CategoryModel _categoryModel;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _fetchNextPageProducts() async {
    if (!_hasMore) {
      showToast(context, '没有更多啦~');
      return;
    }
    setState(() {
      _page++;
    });
    String url = api_prefix + '/products?';
    if (_controller.text.isNotEmpty) {
      url += '&keyword=${_controller.text}';
    }
    if (_category_id != null) {
      url += '&category_id=$_category_id';
    }
    url += '&order_field=$_order_field';
    url += '&order_direction=$_order_direction';
    url += '&page=$_page';
    String token = await getToken();
    if (token.isNotEmpty) {
      http.get(url, headers: {'Authorization': 'Bearer $token'}).then((res) {
        print(res.body);
        ProductListModel _productListModel =
            ProductListModel.fromJson(json.decode(res.body));
        if (_productListModel.errcode != 0) {
          showToast(context, _productListModel.errmsg);
          return;
        }
        if (_productListModel.data.perPage >
            _productListModel.data.data.length) {
          setState(() {
            _isLoading = false;
            _hasMore = false;
            _iterms.addAll(_productListModel.data.data);
          });
        } else {
          setState(() {
            _isLoading = false;
            _hasMore = true;
            _iterms.addAll(_productListModel.data.data);
          });
        }
      });
    }else{
      http.get(url).then((res) {
        ProductListModel _productListModel =
        ProductListModel.fromJson(json.decode(res.body));
        if (_productListModel.errcode != 0) {
          showToast(context, _productListModel.errmsg);
          return;
        }
        if (_productListModel.data.perPage >
            _productListModel.data.data.length) {
          setState(() {
            _isLoading = false;
            _hasMore = false;
            _iterms.addAll(_productListModel.data.data);
          });
        } else {
          setState(() {
            _isLoading = false;
            _hasMore = true;
            _iterms.addAll(_productListModel.data.data);
          });
        }
      });
    }
  }

  @override
  void initState() {
    if (widget.categoryId != null) {
      _category_id = widget.categoryId;
    }
    _controller = TextEditingController.fromValue(
        TextEditingValue(text: widget.keyword ?? ''));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchNextPageProducts();
      }
    });
    super.initState();
    _fetchNextPageProducts();
    _getCategory();
  }

  //获取全部分类数据
  _getCategory(){
    http.get(api_prefix+'/categories')
        .then((res){
      setState(() {
        _categoryModel = category.CategoryModel.fromJson(json.decode(res.body));
      });
    });
  }

  Widget _buildDrawer(){
    if(_categoryModel == null){
      return Container();
    }
    return SmartDrawer(
      widthPercent: 0.7,
      child: Container(
        color: Colors.white70,
        child: Center(
          child: ListView(
            children: _categoryModel.data.map((category.Data data){
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Text(data.title,style: TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent.withOpacity(0.8)
                    ),),
                    ...data.children.map((category.Children child){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(child.title+':',style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.6)
                              ),)
                            ],
                          ),
                          Wrap(
                            children: child.lastChildren.map((category.LastChildren last){
                              return FlatButton(
                                color: _category_id == last.id ? Colors.redAccent.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
                                child: Text(last.title),
                                onPressed: (){
                                  if(_category_id != last.id){
                                    setState(() {
                                      _category_id = last.id;
                                    });
                                    _reFetchProducts();
                                  }else{
                                    setState(() {
                                      _category_id = null;
                                    });
                                    _reFetchProducts();
                                  }
                                },
                              );
                            }).toList(),
                            spacing: 4,
                            runSpacing: 2,
                          )
                        ],
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  _reFetchProducts() {
    setState(() {
      _page = 0;
      _hasMore = true;
      _iterms = [];
    });
    _fetchNextPageProducts();
  }

  Widget _buildTop(con) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: Colors.redAccent.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                '最新',
                style: TextStyle(
                    color: _order_field == 'created_at'
                        ? Colors.blueAccent
                        : Colors.black),
              ),
            ),
            onTap: () {
              setState(() {
                _order_field = 'created_at';
                _order_direction = 'desc';
              });
              _reFetchProducts();
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                '销量',
                style: TextStyle(
                    color: _order_field == 'sales'
                        ? Colors.blueAccent
                        : Colors.black),
              ),
            ),
            onTap: () {
              setState(() {
                _order_field = 'sales';
                _order_direction = 'desc';
              });
              _reFetchProducts();
            },
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '价格',
                    style: TextStyle(
                        color: _order_field == 'lowest_price' ||
                                _order_field == 'highest_price'
                            ? Colors.blueAccent
                            : Colors.black),
                  ),
                ),
                Container(
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: _order_field == 'lowest_price'
                              ? Colors.blueAccent
                              : Colors.brown.withOpacity(0.5),
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            _order_field = 'lowest_price';
                            _order_direction = 'asc';
                          });
                          _reFetchProducts();
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: _order_field == 'highest_price'
                              ? Colors.blueAccent
                              : Colors.brown.withOpacity(0.5),
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            _order_field = 'highest_price';
                            _order_direction = 'desc';
                          });
                          _reFetchProducts();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Builder(
            builder: (con){
              return GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text('分类',style: TextStyle(
                    color: _category_id != null ? Colors.blueAccent : Colors.black
                  ),),
                ),
                onTap: () => _scaffoldKey.currentState.openEndDrawer()
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(int index) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Column(
          children: <Widget>[
            Image.network(
              _iterms[index].imageCover,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(_iterms[index].shortTitle),
            ),
            Divider(
              indent: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\￥${_iterms[index].price}',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                _iterms[index].sellingPoint.isNotEmpty
                    ? Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: _iterms[index]
                                .sellingPoint
                                .split(',')
                                .map((str) => Container(
                                      margin: EdgeInsets.all(1),
                                      child: Text(
                                        str,
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 10),
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.redAccent,
                                              width: 1)),
                                      padding: EdgeInsets.all(1),
                                    ))
                                .toList()),
                      )
                    : Container()
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
                  _reFetchProducts();
                },
              )
            ],
            elevation: 0,
            titleSpacing: 0,
            title: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Color.fromRGBO(51, 51, 51, 1),
                    size: 20,
                  ),
                  Expanded(
                    child: TextField(
                      autofocus: widget.isAutoFocus,
                      controller: _controller,
                      onSubmitted: (value) {
                        _reFetchProducts();
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          hintText: '搜一搜',
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none),
                    ),
                  )
                ],
              ),
            )),
        endDrawer: _buildDrawer(),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 0.001,
              child: _buildTop(context),
            ),
            _isLoading
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 40),
                    color: Colors.grey.withOpacity(0.2),
                    child: StaggeredGridView.countBuilder(
                      controller: _scrollController,
                      primary: false,
                      crossAxisCount: 4,
                      itemCount: _iterms.length,
                      itemBuilder: (BuildContext context, int index) =>
                          TouchCallback(
                            child: _buildProductItem(index),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ProductDetail(
                                  ProductId: _iterms[index].id,
                                );
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
        ));
  }
}
