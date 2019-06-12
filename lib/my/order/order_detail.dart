import 'package:flutter/material.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/touch_callback.dart';

import 'express_detail.dart';

class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

  Widget _buildProductItem(){
    return GestureDetector(
      child: Container(
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
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return ProductDetail();
          })
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.redAccent,Colors.deepOrangeAccent
              ])
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('待评价',style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),),
                ),
              ],
            ),
          ),
          TouchCallback(
            child: Container(
              height: 60,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text('已签收，签收人凭取货码签收',style: TextStyle(
                          color: Colors.green
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 3),
                        child: Text('2019-09-20 17:34:09',style: TextStyle(
                          color: Colors.grey
                        ),),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,),
                ],
              ),
            ),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return ExpressDetail();
                  })
              );
            },
          ),
          Divider(height: 10,),
          Container(
            padding: EdgeInsets.only(top: 10,right: 10,bottom: 10,left: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.place),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('帅纯亮  16601126817'),
                    ),
                    Container(
                      child: Text('湖北省 武汉市 洪山区 高新二路大鹏村公交站江城雅居'),
                    ),
                  ],
                )
              ],
            ),
          ),
          commonDivider(),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('商品详情'),
          ),
          _buildProductItem(),
          _buildProductItem(),
          _buildProductItem(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('实付：\$30(免运费)'),
                )
              ],
            ),
          ),
          commonDivider(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('订单编号：621946120404017'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('支付方式：微信'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('下单时间：2019-09-01 12:09:30'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('发货时间：2019-09-01 12:10:30'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('快递方式：顺丰快递'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('运单编号：73582945674853'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
