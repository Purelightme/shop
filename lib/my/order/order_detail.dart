import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:shop/models/order_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/token.dart';

import 'express_detail.dart';

class OrderDetail extends StatefulWidget {

  OrderDetail({@required this.orderId});

  int orderId;

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

  OrderDetailModel orderDetailModel;
  bool _isLoading = true;

  @override
  initState(){
    super.initState();
    _getOrderDetail();
  }

  _getOrderDetail()async{
    String token = await getToken();
    http.get(api_prefix + '/orders/${widget.orderId}',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      OrderDetailModel _orderDetailModel = OrderDetailModel.fromJson(json.decode(res.body));
      if(_orderDetailModel.errcode != 0){
        showToast(context,_orderDetailModel.errmsg);
      }else{
        setState(() {
          orderDetailModel = _orderDetailModel;
          _isLoading = false;
        });
      }
    });
  }

  Widget _buildProductItem(SpecificationSnapshot ss){
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
                    backgroundImage: NetworkImage(ss.imageCover,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(ss.longTitle,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          width: MediaQuery.of(context).size.width - 160,
                        ),
                        Text('规格：${ss.specificationString}')
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2,vertical: 10),
                  child: Text('\￥${ss.price}'),
                ),
                Container(
                  child: Text('*${ss.number}',style: TextStyle(
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
            return ProductDetail(ProductId: ss.productId,);
          })
        );
      },
    );
  }

  Widget _buildExpressItem(Expresses express){
    return TouchCallback(
      child: Container(
        height: 60,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            express.detail.length != 0 ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(express.detail[0].status,style: TextStyle(
                      color: Colors.green
                  ),),
                ),
                Container(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(express.detail[0].time,style: TextStyle(
                      color: Colors.grey
                  ),),
                )
              ],
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text('暂无物流信息',style: TextStyle(
                      color: Colors.green
                  ),),
                ),
                Container(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(orderDetailModel.data.createdAt,style: TextStyle(
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
              return ExpressDetail(expresses: express,addressSnapshot: orderDetailModel.data.addressSnapshot,);
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
      body: _isLoading ? Container(
        child: Center(
          child: RefreshProgressIndicator(),
        ),
      ) : ListView(
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
                  child: Text(orderDetailModel.data.statusDesc,style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),),
                ),
              ],
            ),
          ),
          ...orderDetailModel.data.expresses.map((express){
            return _buildExpressItem(express);
          }).toList(),
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
                      child: Text(
                          orderDetailModel.data.addressSnapshot.name + '    '+
                          orderDetailModel.data.addressSnapshot.phone
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Text(
                          orderDetailModel.data.addressSnapshot.province + '  ' +
                          orderDetailModel.data.addressSnapshot.city + '   ' + 
                          orderDetailModel.data.addressSnapshot.area + '   ' + 
                          orderDetailModel.data.addressSnapshot.street,
                        softWrap: true,maxLines: 2,overflow: TextOverflow.ellipsis,
                      ),
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
          ...orderDetailModel.data.specificationSnapshot.map((SpecificationSnapshot ss){
            return _buildProductItem(ss);
          }).toList(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('实付：\￥${orderDetailModel.data.amount}(运费:￥${orderDetailModel.data.expressFee})'),
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
                  child: Text('订单编号：${orderDetailModel.data.orderNo}'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('下单时间：${orderDetailModel.data.createdAt}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
