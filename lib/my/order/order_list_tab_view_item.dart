import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/order_list_model.dart';
import 'package:shop/my/order/order_comment.dart';
import 'package:shop/my/order/order_detail.dart';
import 'package:shop/utils/token.dart';
import 'package:http/http.dart' as http;


class OrderListTabViewItem extends StatefulWidget {

  OrderListTabViewItem({@required this.status});

  int status;

  @override
  _OrderListTabViewItemState createState() => _OrderListTabViewItemState();
}

class _OrderListTabViewItemState extends State<OrderListTabViewItem> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  List<Item> _items = [];
  int _page = 0;
  bool _hasMore = true;

  Widget _buildProductItem(int index,SpecificationSnapshot sp){
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

  _noBtns(){
    return [Container()];
  }

  _payed(int index)async{
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
        http.put(api_prefix+'/orders/${_items[index].id}/pay',headers: {
          'Authorization':'Bearer $token'
        }).then((res){
          CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
          if(_commonResModel.errcode != 0){
            showToast(context, _commonResModel.errmsg);
          }else{
            showToast(context, '已通知店长确认');
            setState(() {
              _items[index].status = 2;
              _items[index].statusDesc = '待确认';
            });
          }
        });
      }
    });
  }

  _cancel(int index)async{
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
        http.put(api_prefix+'/orders/${_items[index].id}/cancel',headers: {
          'Authorization':'Bearer $token'
        }).then((res){
          CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
          if(_commonResModel.errcode != 0){
            showToast(context, _commonResModel.errmsg);
          }else{
            showToast(context, '已取消订单');
            setState(() {
              _items[index].status = 0;
              _items[index].statusDesc = '已取消';
            });
          }
        });
      }
    });
  }

  _receive(int index)async{
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
        http.put(api_prefix+'/orders/${_items[index].id}/receive',headers: {
          'Authorization':'Bearer $token'
        }).then((res){
          CommonResModel _commonResModel = CommonResModel.fromJson(json.decode(res.body));
          if(_commonResModel.errcode != 0){
            showToast(context, _commonResModel.errmsg);
          }else{
            showToast(context, '已确认收货');
            setState(() {
              _items[index].status = 5;
              _items[index].statusDesc = '待评价';
            });
          }
        });
      }
    });
  }

  List<Widget> _buildBtns(int index) {
    switch(_items[index].status){
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
              _cancel(index);
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
              _payed(index);
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
              _receive(index);
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
                      specificationSnapshot: _items[index].specificationSnapshot,
                      orderId: _items[index].id,
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

  Widget _buildOrderItem(int index){
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('订单号:${_items[index].orderNo}'),
                  Text('${_items[index].statusDesc}',style: TextStyle(
                      color: Colors.redAccent
                  ),)
                ],
              ),
            ),
            ..._items[index].specificationSnapshot.map((sp){
              return _buildProductItem(index,sp);
            }).toList(),
            Container(
              padding: EdgeInsets.only(top: 8,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('共${_items[index].productNumber}件商品 合计￥${_items[index].amount}'),
                  Text('(含运费￥${_items[index].expressFee})')
                ],
              ),
            ),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _buildBtns(index)
            ),
            commonDivider()
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return OrderDetail(orderId: _items[index].id,);
            })
        );
      },
    );
  }

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
        print('我监听到底部了!');
      }
    });
    super.initState();
    _loadMore();
  }

  _loadMore()async{
    if(!_hasMore){
      showToast(context, '没有更多啦');
      return;
    }
    setState(() {
      _page++;
    });
    String token = await getToken();
    String url;
    if(widget.status == -1){
      url = api_prefix + '/orders?page=$_page';
    }else{
      url = api_prefix + '/orders?status=${widget.status}&page=$_page';
    }
    http.get(url,headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      OrderListModel orderListModel = OrderListModel.fromJson(json.decode(res.body));
      if(orderListModel.errcode != 0){
        showToast(context, orderListModel.errmsg);
        return;
      }
      if(orderListModel.data.data.length < orderListModel.data.perPage){
        setState(() {
          _items.addAll(orderListModel.data.data);
          _hasMore = false;
        });
      }else{
        setState(() {
          _items.addAll(orderListModel.data.data);
          _hasMore = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length,
      itemBuilder: (context,index){
        return _buildOrderItem(index);
      },
    );
  }
}
