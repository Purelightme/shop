import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/image_preview.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:shop/models/order_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/token.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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

  _toPreview(List<String> images,index){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return ImagePreview(images: images,index: index);
        })
    );
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
                    foregroundColor: Colors.redAccent,
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
                  width: MediaQuery.of(context).size.width - 60,
                  child: Text(express.detail[0].status,style: TextStyle(
                      color: Colors.green
                  ),softWrap: true,overflow: TextOverflow.ellipsis,),
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

  Widget _buildComment(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Text('评论详情'),
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey.withOpacity(0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(orderDetailModel.data.comment.createdAt),
                  ),
                  SmoothStarRating(
                    allowHalfRating: true,
                    onRatingChanged: null,
                    starCount: 5,
                    rating: orderDetailModel.data.comment.star.toDouble(),
                    size: 20.0,
                    color: Colors.redAccent,
                    borderColor: Colors.grey,
                  )
                ],
              ),
              Container(
                child: Text(orderDetailModel.data.comment.content,style: TextStyle(
                    fontSize: 16
                ),),
              ),
              orderDetailModel.data.comment.imgs.length == 0 ? Container() :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(),
                  Container(
                    child: Wrap(
                      spacing: 2,
                      runSpacing: 2,
                      children: orderDetailModel.data.comment.imgs.asMap().map((index,url){
                        return MapEntry(index,GestureDetector(
                          child: Image.network(url,width: 100,height: 100,),
                          onTap: (){
                            _toPreview(orderDetailModel.data.comment.imgs,index);
                          },
                        ));
                      }).values.toList(),
                    ),
                  ),
                ],
              )
            ],
          )
        ),
        commonDivider(),
      ],
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
                Padding(
                  child: Icon(Icons.place,color: Colors.blueAccent,),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                ),
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
          orderDetailModel.data.comment != null ? _buildComment() : Container(),
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
                orderDetailModel.data.status == 0 ? Container(
                  padding: EdgeInsets.all(10),
                  child: Text('取消类型：${orderDetailModel.data.canceledBy}'),
                ) : Container(),
                orderDetailModel.data.payTime != null ? Container(
                  padding: EdgeInsets.all(10),
                  child: Text('支付时间：${orderDetailModel.data.payTime}'),
                ) : Container(),
                orderDetailModel.data.receiveTime != null ? Container(
                  padding: EdgeInsets.all(10),
                  child: Text('收货时间：${orderDetailModel.data.receiveTime}'),
                ) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
