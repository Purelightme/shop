import 'package:flutter/material.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/notification.dart';
import 'dart:math';

import 'package:shop/common/touch_callback.dart';

import 'order_detail.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  TabController _tabController;

  Widget _buildProductItem(){
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('images/banners/shoes.jpeg'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('一字鲜麻辣龙虾尾虾球2盒装'),
                        Text('规格：麻辣味')
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('\$39.90'),
                ),
                Container(
                  child: Text('*1',style: TextStyle(
                      color: Colors.grey.withOpacity(0.5)
                  ),),
                )
              ],
            )
          ],
        ),
      );
  }

  Widget _buildOrderItem(){
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('订单号:467532435788'),
                  Text('待评价',style: TextStyle(
                      color: Colors.redAccent
                  ),)
                ],
              ),
            ),
            _buildProductItem(),
            _buildProductItem(),
            _buildProductItem(),
            Container(
              padding: EdgeInsets.only(top: 8,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('共3件商品 合计\$99.00'),
                  Text('(含运费\$5.00)')
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[600],
                        width: 1
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                    child: Text('查看物流',style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                    ),),
                  ),
                  onTap: (){
                    showToast(context,'你点击了按钮');
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey[600],
                            width: 1
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                    child: Text('查看物流',style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  ),
                  onTap: (){
                    showToast(context,'你点击了按钮');
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey[600],
                            width: 1
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                    child: Text('查看物流',style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  ),
                  onTap: (){
                    showToast(context,'你点击了按钮');
                  },
                ),
              ],
            ),
            commonDivider()
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return OrderDetail();
          })
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 5,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('我的订单'),
          centerTitle: true,
          bottom: new TabBar(
            isScrollable: true,
            tabs: <Widget>[
              new Tab(child: Text('全部'),),
              new Tab(child: Text('待付款'),),
              new Tab(child: Text('待发货'),),
              new Tab(child: Text('待收货'),),
              new Tab(child: Text('待评价'),),
            ],
            controller: _tabController,
          ),
        ),
        body: new TabBarView(
          children: [1,2,3,4,5].map((index){
            return ListView(
              children: [0,1,2,3,4,5,6,7].map((i){
                  return _buildOrderItem();
                }).toList()
            );
          }).toList()
        ),
      ),
    );
  }
}
