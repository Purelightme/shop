import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/api/api.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/address_model.dart' as address_model;
import 'package:shop/models/common_res_model.dart';
import 'package:shop/my/order/order_list.dart';
import 'package:shop/utils/token.dart';
import 'package:shop/models/shopping_cart_model.dart' as shopping_cart_model;


class OrderCheck extends StatefulWidget {

  OrderCheck({@required this.carts});

  List<shopping_cart_model.Item> carts;

  @override
  _OrderCheckState createState() => _OrderCheckState();
}

class _OrderCheckState extends State<OrderCheck> {

  TextEditingController _controller = new TextEditingController();

  List<address_model.Data> _addresses = [];
  int _selectedAddressIndex;
  String _remark = '';
  List<shopping_cart_model.Item> _carts = [];
  double _totalFee = 0.00;
  double _expressFee = 0.00;

  @override
  initState(){
    super.initState();
    _initAddress();
    _initCartNumbers();
    _rebuildTotalFee();
  }

  _initCartNumbers(){
    setState(() {
      _carts = widget.carts;
    });
  }

  _initAddress()async{
    String token = await getToken();
    http.get(api_prefix+'/addresses',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      address_model.AddressModel _addressModel = address_model.AddressModel.fromJson(json.decode(res.body));
      if(_addressModel.errcode != 0){
        showToast(context, _addressModel.errmsg);
        return;
      }else{
        if(_addressModel.data.length == 0){
          showToast(context, '请先添加收货地址哦');
          return;
        }
        setState(() {
          _addresses = _addressModel.data;
          _selectedAddressIndex = 0;
        });
      }
    });
  }

  Future _chooseAddress() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        child: SimpleDialog(
            title: Text('亲，选择收货地址~'),
            children: _addresses.asMap().map((int i,address_model.Data data){
              return MapEntry(i,SimpleDialogOption(
                child: Container(
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(data.name.substring(0,1),style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text('${data.name}  ${data.phone}'),
                              ),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                child: Text('${data.province} ${data.city} ${data.area}',
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                child: Text(data.street,
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                ),
                onPressed: () {
                  setState(() {
                    _selectedAddressIndex = i;
                  });
                  Navigator.pop(context);
                },
              ));
            }).values.toList()
        )
    );
  }

  _createOrder()async{
    String token = await getToken();
    if(token.isEmpty){
      showToast(context, '请先登录~',duration: 3);
      return;
    }
    Map<String,dynamic> _body = {};

    _carts.asMap().forEach((index,item){
      _body['shopping_carts[$index][id]'] = item.id.toString();
      _body['shopping_carts[$index][number]'] = item.number.toString();
    });
    _body['address_id'] = _addresses[_selectedAddressIndex].id.toString();
    _body['remark'] = _remark;
    http.post(api_prefix+'/shopping-cart/order',headers: {
      'Authorization':'Bearer $token'
    },body: _body).then((res){
      CommonResModel _CommonResModel = CommonResModel.fromJson(json.decode(res.body));
      if(_CommonResModel.errcode != 0){
        showToast(context, _CommonResModel.errmsg);
      }else{
        showToast(context, '下单成功');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context){
              return OrderList(initIndex: 0,);
            })
        );
      }
    });
  }

  _confirm(){
    showDialog(
        context: context,
        barrierDismissible: true,
        child: AlertDialog(
          title: Text('下单'),
          content: Text('亲，确定下单吗？'),
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
    ).then((value){
      if(value == 'ok'){
        _createOrder();
      }
    });
  }

  _rebuildTotalFee(){
    double totalFee = 0;
    double expressFee = 0;
    print(_carts);
    _carts.map((shopping_cart_model.Item item){
      totalFee += double.parse(item.productSpecification.price) * item.number;
      expressFee += double.parse(item.product.expressFee);
    }).toList();
    setState(() {
      _totalFee = totalFee;
      _expressFee = expressFee;
    });
  }

  Widget _buildCartItem(shopping_cart_model.Item item,int index){
    return Column(
      children: <Widget>[
        Divider(),
        Row(
          children: <Widget>[
            Padding(
              child: Image.network(item.product.imageCover,width: 100,fit: BoxFit.cover,),
              padding: EdgeInsets.all(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 220,
                  child: Text(item.product.longTitle,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('规格：${item.productSpecification.specificationString}',style: TextStyle(
                    color: Colors.grey
                ),),
                Text('单价：￥${item.productSpecification.price}',style: TextStyle(
                    color: Colors.grey
                ),),
                Text('运费：￥${item.product.expressFee}',style: TextStyle(
                    color: Colors.grey
                ),),
              ],
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (){
                        if(item.number < 20){
                          setState(() {
                            _carts[index].number++;
                          });
                          _rebuildTotalFee();
                        }
                      },
                    ),
                    Text('×'+item.number.toString(),style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.redAccent
                    ),),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: (){
                        if(item.number > 1){
                          setState(() {
                            _carts[index].number--;
                          });
                          _rebuildTotalFee();
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        title: Text('立即购买'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                _selectedAddressIndex != null ?
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 10,right: 10,bottom: 10,left: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          child: Icon(Icons.place,color: Colors.blue,),
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text('${_addresses[_selectedAddressIndex].name}  ${_addresses[_selectedAddressIndex].phone}'),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text('${_addresses[_selectedAddressIndex].province} ${_addresses[_selectedAddressIndex].city} '
                                  '${_addresses[_selectedAddressIndex].area} ${_addresses[_selectedAddressIndex].street}',
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,size: 18,color: Colors.blue,),
                      ],
                    ),
                  ),
                  onTap: (){
                    _chooseAddress();
                  },
                ) : Container(),
                Column(
                  children: _carts.asMap().map((index,item){
                    return MapEntry(index,_buildCartItem(item, index));
                  }).values.toList()
                ),
                commonDivider(opacity: 0.1),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text('留言：'),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) {
                            setState(() {
                              _remark = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: '选填，备注特殊要求',
                              contentPadding: EdgeInsets.all(0),
                              hintStyle: TextStyle(fontSize: 14),
                              border: InputBorder.none
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                commonDivider(opacity: 0.1),
                Container(
                  height: 100,
                )
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('实付款：', style: TextStyle(
                                  fontSize: 14
                              )),
                              Text('￥$_totalFee', style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 18
                              )),
                              SizedBox(width: 5,),
                              Text(_expressFee == 0 ? '免运费' : '含运费：￥' + _expressFee.toString(),style: TextStyle(
                                color: Colors.redAccent,
                              ),)
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 36),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                          ),
                          child: Text('提交订单',style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),),
                        ),
                        onTap: (){
                          if(_selectedAddressIndex == null){
                            showToast(context, '请先选择收货地址');
                          }else{
                            _confirm();
                          }
                        },
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}
