import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/shopping_cart_model.dart';
import 'package:shop/utils/token.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  List<Item> _items;
  int _page = 1;
  bool _isLoading = true;
  bool _isSelectedAll = false;
  double _expressFee = 0;
  double _totalFee = 0;
  int _totalNumber = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.position);
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    _getFirstPageData();
  }

  _getFirstPageData()async{
    String token = await getToken();
    http.get(api_prefix + '/user/shopping_carts',headers: {
      'Authorization':'Bearer ' + token
    }).then((res){
      ShoppingCartModel shoppingCartModel = ShoppingCartModel.fromJson(json.decode(res.body));
      setState(() {
        _items = shoppingCartModel.data.data;
        _isLoading = false;
      });
      _rebuildTotalFeeAndNumber();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
    String token = await getToken();
    http.get(api_prefix + '/user/shopping_carts?page=$_page',headers: {
      'Authorization':'Bearer ' + token
    },).then((res){
      ShoppingCartModel shoppingCartModel = ShoppingCartModel.fromJson(json.decode(res.body));
      setState(() {
        _items = shoppingCartModel.data.data;
        _isLoading = false;
      });
      _rebuildTotalFeeAndNumber();
    });
  }

  Future<List<int>> fakeRequest(int from, int to) async {
    return Future.delayed(Duration(seconds: 2), () {
      return List.generate(to - from, (i) => i + from);
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
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
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                        onPressed: (){
                          _chooseSpecification(context,item,index);
                        },
                      ),
                    ],
                  ),
                  Text('\￥'+item.productSpecification.price,style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.red
                  ),)
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

  _chooseSpecification(context,Item item,index) {
    showModalBottomSheet(
        context: context,
        builder: (context){
          return StatefulBuilder(
            builder: (context1,state){
              return GestureDetector(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(item.product.imageCover),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('￥${item.isDoubleSpecification ?
                                item.doubleSpecification[item.productSpecification.firstIndex].children[item.productSpecification.secondIndex].children[0].price:
                                item.singleSpecification[item.productSpecification.firstIndex].children[0].price}', style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500
                                ),),
                                Text('库存${item.isDoubleSpecification ?
                                item.doubleSpecification[item.productSpecification.firstIndex].children[item.productSpecification.secondIndex].children[0].stock:
                                item.singleSpecification[item.productSpecification.firstIndex].children[0].stock}', style: TextStyle(
                                    color: Colors.grey.withOpacity(0.6)
                                ),),
                                Text('已选：' + (item.isDoubleSpecification ?
                                item.doubleSpecification[item.productSpecification.firstIndex].title + ' ' + item.doubleSpecification[item.productSpecification.firstIndex].children[item.productSpecification.secondIndex].title:
                                item.singleSpecification[item.productSpecification.firstIndex].title))
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildSpecification(state,item,index),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  return false;
                },
              );
            },
          );
        }
    ).then((val) {

    });
  }

  List<Widget> _buildSpecification(state,Item item,index){
    if (item.isDoubleSpecification){
      return [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(item.doubleSpecification[0].rootTitle),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
              spacing: 10,
              children: item.doubleSpecification.asMap().map((i,DoubleSpecification value){
                return MapEntry(i,GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                    decoration: BoxDecoration(
                        color: item.productSpecification.firstIndex == i ? Colors.deepOrangeAccent : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Text(value.title,style: TextStyle(
                        fontWeight: FontWeight.w100
                    ),),
                  ),
                  onTap: (){
                    state(() {
                      item.productSpecification.firstIndex = i;
                      if(item.doubleSpecification[item.productSpecification.firstIndex].children.length <= item.productSpecification.secondIndex){
                        item.productSpecification.secondIndex = 0;
                      }
                      item.productSpecification.id = item.doubleSpecification[item.productSpecification.firstIndex]
                          .children[item.productSpecification.secondIndex].children[0].id;
                      item.productSpecification.price = item.doubleSpecification[item.productSpecification.firstIndex]
                          .children[item.productSpecification.secondIndex].children[0].price;
                      item.productSpecification.specificationString = item.doubleSpecification[item.productSpecification.firstIndex]
                          .title + ';' + item.doubleSpecification[item.productSpecification.firstIndex].children[item.productSpecification.secondIndex]
                      .title;
                    });
                    setState(() {
                      item.productSpecification.firstIndex = i;
                      if(item.doubleSpecification[item.productSpecification.firstIndex].children.length <= item.productSpecification.secondIndex){
                        item.productSpecification.secondIndex = 0;
                      }
                      item.productSpecification.id = item.doubleSpecification[item.productSpecification.firstIndex]
                          .children[item.productSpecification.secondIndex].children[0].id;
                      item.productSpecification.price = item.doubleSpecification[item.productSpecification.firstIndex]
                          .children[item.productSpecification.secondIndex].children[0].price;
                      item.productSpecification.specificationString = item.doubleSpecification[item.productSpecification.firstIndex]
                          .title + ';' + item.doubleSpecification[item.productSpecification.firstIndex].children[item.productSpecification.secondIndex]
                          .title;
                    });
                    _rebuildTotalFeeAndNumber();
                  },
                ));
              }).values.toList()
          ),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(item.doubleSpecification[0].children[0].rootTitle),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
              spacing: 10,
              children: item.doubleSpecification[item.productSpecification.firstIndex].children.asMap().map((i, val){
                return MapEntry(i,GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                    decoration: BoxDecoration(
                        color: item.productSpecification.secondIndex == i ? Colors.deepOrangeAccent : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Text(val.title,style: TextStyle(
                        fontWeight: FontWeight.w100
                    ),),
                  ),
                  onTap: (){
                    state(() {
                      item.productSpecification.secondIndex = i;
                      item.productSpecification.id = item.doubleSpecification[item.productSpecification.firstIndex]
                          .children[item.productSpecification.secondIndex].children[0].id;
                      item.productSpecification.price = item.doubleSpecification[item.productSpecification.firstIndex]
                          .children[item.productSpecification.secondIndex].children[0].price;
                      item.productSpecification.specificationString = item.doubleSpecification[item.productSpecification.firstIndex]
                          .title + ';' + item.doubleSpecification[item.productSpecification.firstIndex].children[item.productSpecification.secondIndex]
                          .title;
                    });
                    setState(() {
                      item.productSpecification.id = item.doubleSpecification[item.productSpecification.firstIndex]
                          .children[item.productSpecification.secondIndex].children[0].id;
                      item.productSpecification.price = item.doubleSpecification[item.productSpecification.firstIndex]
                          .children[item.productSpecification.secondIndex].children[0].price;
                      item.productSpecification.specificationString = item.doubleSpecification[item.productSpecification.firstIndex]
                          .title + ';' + item.doubleSpecification[item.productSpecification.firstIndex].children[item.productSpecification.secondIndex]
                          .title;
                    });
                    _rebuildTotalFeeAndNumber();
                  },
                ));
              }).values.toList()
          ),
        ),
      ];
    }else{
      return [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(item.singleSpecification[0].rootTitle),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
              spacing: 10,
              children: item.singleSpecification.asMap().map((i,  value) {
                return MapEntry(i,GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                        color: item.productSpecification.firstIndex == i ? Colors.deepOrangeAccent : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Text(value.title, style: TextStyle(
                        fontWeight: FontWeight.w100
                    ),),
                  ),
                  onTap: (){
                    state(() {
                      item.productSpecification.firstIndex = i;
                      item.productSpecification.id = item.singleSpecification[item.productSpecification.firstIndex]
                          .children[0].id;
                      item.productSpecification.price = item.singleSpecification[item.productSpecification.firstIndex]
                          .children[0].price;
                      item.productSpecification.specificationString = item.singleSpecification[item.productSpecification.firstIndex]
                          .title;
                    });
                    setState(() {
                      item.productSpecification.id = item.singleSpecification[item.productSpecification.firstIndex]
                          .children[0].id;
                      item.productSpecification.price = item.singleSpecification[item.productSpecification.firstIndex]
                          .children[0].price;
                      item.productSpecification.specificationString = item.singleSpecification[item.productSpecification.firstIndex]
                          .title;
                    });
                    _rebuildTotalFeeAndNumber();
                  },
                ));
              }).values.toList()
          ),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的购物车'),
      ),
        body: _isLoading ? Container() : Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      if (index == _items.length) {
                        return _buildProgressIndicator();
                      } else {
                        return _buildProduct(_items[index],index);
                      }
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
                        Container(
                          alignment: Alignment.center,
                          child: new Text(
                            "结算($_totalNumber)",
                            style: TextStyle(color: Colors.white),
                          ),
                          width: 130,
                          height: 50,
                          color: Colors.red,
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
