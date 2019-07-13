import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/order_list_model.dart';
import 'package:shop/my/order/order_comment.dart';
import 'package:shop/utils/token.dart';
import 'order_detail.dart';
import 'package:http/http.dart' as http;

class OrderList extends StatefulWidget {

  OrderList({@required this.status});

  int status;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  Map<int,List> _items = {
    -1:<Item>[],
    1:<Item>[],
    3:<Item>[],
    4:<Item>[],
    5:<Item>[],
  };

  Map<int,int> indexes = {
    -1:0,
    1:1,
    3:2,
    4:3,
    5:4
  };

  TabController _tabController;

  Widget _buildProductItem(int status,int index,SpecificationSnapshot sp){
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey.withOpacity(0.1),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(sp.imageCover),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(sp.longTitle,softWrap: true,maxLines: 1,overflow: TextOverflow.ellipsis,),
                        Text('规格：${sp.specificationString}')
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                  margin: EdgeInsets.all(10),
                    child: Text('\￥${sp.price}',),
                  ),
                  Container(
                    child: Text('×${sp.number}',style: TextStyle(
                        color: Colors.grey.withOpacity(0.5)
                    ),),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }

  _payed(int status,int index)async{
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('已付款'),
        content: Text('我已付款，通知店长确认'),
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
        http.put(api_prefix+'/orders/${_items[status][index].id}/pay',headers: {
          'Authorization':'Bearer $token'
        }).then((res){
          CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
          if(_commonResModel.errcode != 0){
            showToast(context, _commonResModel.errmsg);
          }else{
            showToast(context, '已通知店长确认');
            setState(() {
              _items[status][index].status = 2;
              _items[status][index].statusDesc = '待确认';
            });
          }
        });
      }
    });
  }

  _cancel(int status,int index)async{
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text('取消订单'),
          content: Text('取消订单，不可撤销，亲是否真的要取消？'),
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
        http.put(api_prefix+'/orders/${_items[status][index].id}/cancel',headers: {
          'Authorization':'Bearer $token'
        }).then((res){
          CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
          if(_commonResModel.errcode != 0){
            showToast(context, _commonResModel.errmsg);
          }else{
            showToast(context, '已取消订单');
            setState(() {
              _items[status][index].status = 0;
              _items[status][index].statusDesc = '已取消';
            });
          }
        });
      }
    });
  }

  _receive(int status,int index)async{
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text('确认收货'),
          content: Text('请亲真正收到宝贝之后再确认收货哦，确定收货吗？'),
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
        http.put(api_prefix+'/orders/${_items[status][index].id}/receive',headers: {
          'Authorization':'Bearer $token'
        }).then((res){
          CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
          if(_commonResModel.errcode != 0){
            showToast(context, _commonResModel.errmsg);
          }else{
            showToast(context, '已确认收货');
            setState(() {
              _items[status][index].status = 5;
              _items[status][index].statusDesc = '待评价';
            });
          }
        });
      }
    });
  }

  List<Widget> _buildBtns(int status, int index) {
    switch(_items[status][index].status){
      case 0:
        return _noBtns();
        break;
      case 1:
        return [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey[600],
                      width: 1
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Text('取消订单', style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              ),),
            ),
            onTap: () {
              _cancel(status, index);
            },
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey[600],
                      width: 1
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Text('我已付款', style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              ),),
            ),
            onTap: () {
              _payed(status, index);
            },
          ),
        ];
        break;
      case 2:
        return _noBtns();
        break;
      case 3:
        return [];
        break;
      case 4:
        return [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey[600],
                      width: 1
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Text('确认收货', style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              ),),
            ),
            onTap: () {
              _receive(status, index);
            },
          ),
        ];
        break;
      case 5:
        return [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey[600],
                      width: 1
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Text('评价', style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              ),),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return OrderComment(
                    specificationSnapshot: _items[status][index].specificationSnapshot,
                    orderId: _items[status][index].id,
                  );
                })
              );
            },
          ),
        ];
        break;
      case 6:
        return _noBtns();
        break;
    }
  }

  _noBtns(){
    return [Container()];
  }

  Widget _buildOrderItem(int status,int index){
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('订单号:${_items[status][index].orderNo}'),
                  Text('${_items[status][index].statusDesc}',style: TextStyle(
                      color: Colors.redAccent
                  ),)
                ],
              ),
            ),
            ..._items[status][index].specificationSnapshot.map((sp){
              return _buildProductItem(status,index,sp);
            }).toList(),
            Container(
              padding: EdgeInsets.only(top: 8,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('共${_items[status][index].productNumber}件商品 合计￥${_items[status][index].amount}'),
                  Text('(含运费￥${_items[status][index].expressFee})')
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _buildBtns(status,index)
            ),
            commonDivider()
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return OrderDetail(orderId: _items[status][index].id,);
          })
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getFirstPageByStatus(widget.status);
    _tabController = new TabController(length: 5,vsync: this);
    _tabController.addListener((){
      switch(_tabController.index){
        case 0:
          _getFirstPageByStatus(-1);
          break;
        case 1:
          _getFirstPageByStatus(1);
          break;
        case 2:
          _getFirstPageByStatus(3);
          break;
        case 3:
          _getFirstPageByStatus(4);
          break;
        case 4:
          _getFirstPageByStatus(5);
          break;
      }
    });
  }

  _getFirstPageByStatus(int status)async{
    String token = await getToken();
    String url;
    if(status == -1){
      url = api_prefix + '/orders';
    }else{
      url = api_prefix + '/orders?status=$status';
    }
    http.get(url,headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      OrderListModel orderListModel = OrderListModel.fromJson(json.decode(res.body));
      setState(() {
        _items[status].addAll(orderListModel.data.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('我的订单'),
          centerTitle: true,
          bottom: new TabBar(
            tabs: <Widget>[
              new Tab(text: '全部',),
              new Tab(child: Text('待付款'),),
              new Tab(child: Text('待发货'),),
              new Tab(child: Text('待收货'),),
              new Tab(child: Text('待评价'),),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [-1,1,3,4,5].map((status){
            return ListView.builder(
              itemCount: _items[status].length,
              itemBuilder: (context,index){
                return _buildOrderItem(status,index);
              },
            );
          }).toList()
        ),
      );
  }
}
