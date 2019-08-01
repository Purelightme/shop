import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:shop/common/notification.dart';
import 'package:shop/models/shopping_cart_model.dart';
import 'package:shop/utils/token.dart';

import 'order_check.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  ScrollController _scrollController = new ScrollController();
  List<Item> _items = [];
  int _page = 0;
  bool _isLoading = true;
  bool _isSelectedAll = false;
  double _expressFee = 0;
  double _totalFee = 0;
  int _totalNumber = 0;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchNextPageCart();
      }
    });
    _fetchNextPageCart();
  }

  _fetchNextPageCart()async{
    if(!_hasMore){
      showToast(context,'没有更多啦~');
      return;
    }
    setState(() {
      _page++;
    });
    String token = await getToken();
    http.get(api_prefix + '/user/shopping_carts?page=$_page',headers: {
      'Authorization':'Bearer ' + token
    }).then((res){
      setState(() {
        _isLoading = false;
      });
      ShoppingCartModel _shoppingCartModel = ShoppingCartModel.fromJson(json.decode(res.body));
      if(_shoppingCartModel.data.perPage > _shoppingCartModel.data.data.length){
        setState(() {
          _hasMore = false;
          _items.addAll(_shoppingCartModel.data.data);
        });
      }else{
        _hasMore = true;
        _items.addAll(_shoppingCartModel.data.data);
      }
      _rebuildTotalFeeAndNumber();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _orderCheck(){
    List<Item> _carts = _items.where((i) => i.isChecked == true).toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return OrderCheck(carts: _carts,);
    })).then((res){
      setState(() {
        _page = 0;
        _hasMore = true;
        _items = [];
      });
      _fetchNextPageCart();
    });
  }

  Widget _buildProduct(Item item,int index){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: item.isChecked,
            onChanged: (val){
              setState(() {
                _items[index].isChecked = val;
              });
              _rebuildTotalFeeAndNumber();
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 12.0,right: 15.0),
            child: Image.network(item.product.imageCover,width: 70.0,height: 70.0,),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(item.product.longTitle,style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF353535)
                ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(item.productSpecification.specificationString,style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFFa9a9a9)
                    ),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('\￥'+item.productSpecification.price,style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.red
                    ),),
                    Text(item.product.expressFee == '0.00' ? '(免运费)' : '(运费：￥' + item.product.expressFee + ')',style: TextStyle(
                      color: Colors.grey
                    ),)
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12.0,right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    if(item.number < 20){
                      setState(() {
                        _items[index].number++;
                      });
                      _rebuildTotalFeeAndNumber();
                    }
                  },
                ),
                Text('×'+item.number.toString(),style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.redAccent
                ),),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: (){
                    if(item.number > 1){
                      setState(() {
                        _items[index].number--;
                      });
                      _rebuildTotalFeeAndNumber();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _rebuildTotalFeeAndNumber(){
    double express = 0;
    double totalFee = 0;
    int number = 0;
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].isChecked){
        express += double.parse(_items[i].product.expressFee);
        totalFee += double.parse(_items[i].productSpecification.price) * _items[i].number;
        number += _items[i].number;
      }
    }
    setState(() {
      _expressFee = express;
      _totalFee = totalFee + express;
      _totalNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的购物车'),
        ),
        body: _isLoading ? Container(
          child: Center(
            child: RefreshProgressIndicator(),
          ),
        ) : Column(
          children: <Widget>[
            Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return _buildProduct(_items[index],index);
                      }
                  )
              ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _isSelectedAll,
                  onChanged: (val){
                    setState(() {
                      _isSelectedAll = val;
                      _items = _items.map((Item item){
                        item.isChecked = val;
                        return item;
                      }).toList();
                    });
                    _rebuildTotalFeeAndNumber();
                  },
                ),
                Text('全选'),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          _expressFee == 0 ? '不含运费' : '含运费：￥$_expressFee',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        Text(
                          "合计:",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        Text(
                          "￥",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        Text(
                          "$_totalFee",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            child: new Text(
                              "结算($_totalNumber)",
                              style: TextStyle(color: Colors.white),
                            ),
                            width: 130,
                            height: 50,
                            color: Colors.red,
                          ),
                          onTap: (){
                            _orderCheck();
                          },
                        )
                      ],
                    )
                ),
              ],
            ),
          ],
        )
    );
  }
}
