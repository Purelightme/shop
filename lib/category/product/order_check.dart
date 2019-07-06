import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:shop/common/notification.dart';
import 'package:shop/models/address_model.dart' as am;
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/product_specification_model.dart';
import 'package:shop/utils/token.dart';

class OrderCheck extends StatefulWidget {

  OrderCheck({@required this.ProductSpecificationId});

  int ProductSpecificationId;

  @override
  _OrderCheck createState() => _OrderCheck();
}

class _OrderCheck extends State<OrderCheck> {

  TextEditingController _controller = new TextEditingController();

  Data _data;
  int _num = 1;
  List<am.Data> _addresses = [];
  int _selectedAddressIndex;
  String _remark;

  @override
  initState(){
    super.initState();
    print(widget.ProductSpecificationId);
    _loadProductSpecification();
    _initAddress();
  }

  _loadProductSpecification(){
    http.get(api_prefix+'/product-specifications/${widget.ProductSpecificationId}')
        .then((res){
          ProductSpecificationModel _productSpecificationModel = ProductSpecificationModel.fromJson(json.decode(res.body));
          if(_productSpecificationModel.errcode != 0){
            showToast(context,_productSpecificationModel.errmsg);
          }else{
            setState(() {
              _data = _productSpecificationModel.data;
            });
          }
    });
  }

  _initAddress()async{
    String token = await getToken();
    http.get(api_prefix+'/addresses',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      am.AddressModel _addressModel = am.AddressModel.fromJson(json.decode(res.body));
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
          title: Text('选择收货地址'),
          children: _addresses.asMap().map((int i,am.Data data){
            return MapEntry(i,SimpleDialogOption(
              child: Container(
                  child:  Container(
                      color: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
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
                                    .width * 0.6,
                                child: Text('${data.province} ${data.city} ${data.area} ${data.street}',
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
    http.post(api_prefix+'/orders',headers: {
      'Authorization':'Bearer $token'
    },body: {
      'product_specifications[0][id]':widget.ProductSpecificationId.toString(),
      'product_specifications[0][number]':_num.toString(),
      'address_id':_addresses[_selectedAddressIndex].id.toString(),
      'remark': _remark
    }).then((res){
      CommonResModel _CommonResModel = CommonResModel.fromJson(json.decode(res.body));
      print(res.body);
      if(_CommonResModel.errcode != 0){
        showToast(context, _CommonResModel.errmsg);
      }else{
        showToast(context, '下单成功');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Icon(Icons.place),
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
                        Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,),
                      ],
                    ),
                  ),
                  onTap: (){
                    _chooseAddress();
                  },
                ) : Container(),
                commonDivider(opacity: 0.1),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1)
                  ),
                  child: _data != null ? Row(
                    children: <Widget>[
                      Padding(
                        child: Image.network(_data.imageCover,width: 100,fit: BoxFit.cover,),
                        padding: EdgeInsets.all(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            child: Text(_data.longTitle,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text('规格：${_data.specificationString}',style: TextStyle(
                            color: Colors.grey
                          ),),
                          Text('￥${_data.price}')
                        ],
                      ),
                    ],
                  ) : Container()
                ),
                commonDivider(opacity: 0.1),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('购买数量'),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              width: 25,
                              height: 25,
                              color: Colors.grey.withOpacity(0.5),
                              child: Icon(Icons.remove),
                            ),
                            onTap: (){
                              if(_num > 1){
                                setState(() {
                                  _num--;
                                });
                              }
                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(_num.toString()),
                          ),
                          GestureDetector(
                            child: Container(
                              width: 25,
                              height: 25,
                              color: Colors.grey.withOpacity(0.2),
                              child: Icon(Icons.add),
                            ),
                            onTap: (){
                              if(_num < 20){
                                setState(() {
                                  _num++;
                                });
                              }
                            },
                          )
                        ],
                      )
                    ],
                  ),
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
                    _data != null ? Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('实付款：', style: TextStyle(
                                fontSize: 14
                            )),
                            Text('￥${double.parse(_data.price)*_num + double.parse(_data.expressFee)}', style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18
                            )),
                            SizedBox(width: 5,),
                            Text(_data.expressFee.startsWith('0') ? '免运费' : '含运费￥${_data.expressFee}',style: TextStyle(
                              color: Colors.redAccent,
                            ),)
                          ],
                        ),
                      ),
                    ) : Container(),
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
                          _createOrder();
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
