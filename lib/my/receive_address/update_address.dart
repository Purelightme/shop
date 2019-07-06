import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/common/provinces.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/utils/token.dart';
import 'package:http/http.dart' as http;

class UpdateAddress extends StatefulWidget {

  UpdateAddress({@required this.item});

  Data item;

  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {

  GlobalKey<FormState> updateAddressKey = new GlobalKey<FormState>();

  String province;
  String city;
  String area;
  String locationCode;
  String street;
  String name;
  String phone;

  @override
  void initState(){
    super.initState();
    _setInit();
  }

  _setInit(){
    setState(() {
      province = widget.item.province;
      city = widget.item.city;
      area = widget.item.area;
      locationCode = widget.item.areaId;
    });
  }

  _updateAddress()async{
    var updateForm = updateAddressKey.currentState;
    if (updateForm.validate()){
      updateForm.save();
      String token = await getToken();
      http.put(api_prefix + '/addresses/${widget.item.id}',headers: {
        'Authorization':'Bearer $token'
      },body: {
        'province':province,
        'city':city,
        'area':area,
        'area_id':locationCode,
        'street':street,
        'name':name,
        'phone':phone
      }).then((res){
        setState(() {
          CommonResModel commonResModel = CommonResModel.fromJson(json.decode(res.body));
          if(commonResModel.errcode != 0){
            showToast(context, commonResModel.errmsg);
          }else{
            showToast(context, commonResModel.errmsg);
            Navigator.of(context).pushReplacementNamed('/receive_address');
          }
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑收货地址'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: updateAddressKey,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          province != null ?
                          '已选择:$province$city$area' :
                          '请选择'
                      ),

                      RaisedButton(
                        child: Text('选择省市区'),
                        onPressed: () async {
                          Result result = await CityPickers.showCityPicker(
                              context: context,
                              locationCode: widget.item.areaId,
                              provincesData: provincesData
                          );
                          print(result);
                          setState(() {
                            if (result != null) {
                              province = result.provinceName;
                              city = result.cityName;
                              area = result.areaName;
                              locationCode = result.areaId;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: widget.item.street,
                    decoration: InputDecoration(
                      labelText: '街道详细地址',
                    ),
                    onSaved: (value){
                      street = value;
                    },
                    onFieldSubmitted: (value){},
                    validator: (value){
                      return value.length == 0 ? '请填写街道地址' : null;
                    },
                  ),
                  TextFormField(
                    initialValue: widget.item.name,
                    decoration: InputDecoration(
                        labelText: '收件人姓名'
                    ),
                    onSaved: (value){
                      name = value;
                    },
                    onFieldSubmitted: (value){},
                    validator: (value){
                      return value.length == 0 ? '请填写收件人姓名' : null;
                    },
                  ),
                  TextFormField(
                    initialValue: widget.item.phone,
                    decoration: InputDecoration(
                        labelText: '收件人手机号'
                    ),
                    onSaved: (value){
                      phone = value;
                    },
                    onFieldSubmitted: (value){},
                    validator: (value){
                      return value.length == 0 ? '请填写收件人手机号' : null;
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 340.0,
            height: 42.0,
            child: RaisedButton(
              color: Color(0xffff1644),
              onPressed: (){
                _updateAddress();
              },
              child: Text('确认添加',style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white
              ),),
            ),
          )
        ],
      ),
    );
  }
}
