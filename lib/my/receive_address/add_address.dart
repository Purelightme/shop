import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/common/provinces.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/common_res_model.dart';
import 'package:shop/utils/token.dart';


class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  GlobalKey<FormState> addAddressKey = new GlobalKey<FormState>();

  String province;
  String city;
  String area;
  String locationCode;
  String street;
  String name;
  String phone;

  _addAddress()async{
    var addForm = addAddressKey.currentState;
    if (addForm.validate()){
      addForm.save();
      String token = await getToken();
      http.post(api_prefix + '/addresses',headers: {
        'Authorization':'Bearer $token',
        'X-Requested-With':'XMLHttpRequest'
      },body: {
        'province':province,
        'city':city,
        'area':area,
        'area_id':locationCode,
        'street':street,
        'name':name,
        'phone':phone
      }).then((res){
        CommonResModel commonResModel = CommonResModel.fromJson(json.decode(res.body));
        if(commonResModel.errcode != 0){
          showToast(context,commonResModel.errmsg);
        }else{
          showToast(context, commonResModel.errmsg);
          Navigator.of(context).pushReplacementNamed('/receive_address');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加收货地址'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: addAddressKey,
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
                              locationCode: locationCode,
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
                    decoration: InputDecoration(
                        labelText: '街道详细地址'
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
              onPressed: _addAddress,
              child: Text('确认添加',style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white
              ),),
            ),
          )
        ],
      )
    );
  }
}
