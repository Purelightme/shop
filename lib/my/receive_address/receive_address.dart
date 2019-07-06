import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/notification.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/address_model.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/my/receive_address/update_address.dart';
import 'package:shop/utils/token.dart';

class ReceiveAddress extends StatefulWidget {
  @override
  _ReceiveAddressState createState() => _ReceiveAddressState();
}

class _ReceiveAddressState extends State<ReceiveAddress> {


  AddressModel _addressModel;
  List<Data> _items = [];

  @override
  void initState() {
    super.initState();
    _getFirstPageData();
  }

  _getFirstPageData()async{
    String token = await getToken();
    http.get(api_prefix + '/addresses',headers: {
      'Authorization':'Bearer ' + token
    }).then((res){
      setState(() {
        _addressModel = AddressModel.fromJson(json.decode(res.body));
        _items.addAll(_addressModel.data);
      });
    });
  }


  _deleteAddress(Data data)async{
    String token = await getToken();
    http.delete(api_prefix + '/addresses/${data.id}',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      CommonResModel commonResModel = CommonResModel.fromJson(json.decode(res.body));
      if(commonResModel.errcode != 0){
        showToast(context, commonResModel.errmsg);
      }else{
        showToast(context,commonResModel.errmsg);
        Navigator.of(context).pushReplacementNamed('/receive_address');
      }
    });
  }

  _setDefault(Data data)async{
    String token = await getToken();
    http.put(api_prefix + '/addresses/${data.id}/default',headers: {
      'Authorization':'Bearer $token'
    }).then((res){
      CommonResModel commonResModel = CommonResModel.fromJson(json.decode(res.body));
      if(commonResModel.errcode != 0){
        showToast(context, commonResModel.errmsg);
      }else{
        showToast(context,commonResModel.errmsg);
        Navigator.of(context).pushReplacementNamed('/receive_address');
      }
    });
  }

  Widget _buildAddressItem(Data data){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 30.0,top: 20,bottom: 20),
        child: Row(
          children: <Widget>[
            data.isDefault ? Padding(
              padding: EdgeInsets.all(10),
              child: Text('当前默认',style: TextStyle(color: Colors.redAccent),),
            ) : Container(),
            CircleAvatar(
              child: Text(data.name.substring(0,1),style: TextStyle(
                fontSize: 14,
              ),),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Baseline(
                        baseline: 0.0,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(data.name,style: TextStyle(
                            fontSize: 18.0
                        ),),
                      ),
                      Baseline(
                          baseline: 0.0,
                          baselineType: TextBaseline.alphabetic,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(data.phone,style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey
                            ),),
                          )
                      ),
                    ],
                  ),
                  Text('${data.province} ${data.city} ${data.area}'),
                  Container(
                    child: Text(data.street,softWrap: true,maxLines: 3,),
                    width: data.isDefault ? MediaQuery.of(context).size.width - 170 :
                        MediaQuery.of(context).size.width - 100,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onLongPress: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return UpdateAddress(item: data,);
        }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址管理'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed('/add_address');
            },
          )
        ],
      ),
      body: _items.length == 0 ? Container() :
      ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Slidable(
              key: ValueKey(index),
              actionPane: SlidableBehindActionPane(),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: '设为默认',
                  color: Colors.grey.shade200,
                  icon: Icons.settings,
                  onTap: (){
                    _setDefault(_items[index]);
                  },
                ),
                IconSlideAction(
                  caption: '删除',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: (){
                    _deleteAddress(_items[index]);
                  },
                ),
              ],
              dismissal: SlidableDismissal(
                child: SlidableDrawerDismissal(),
                closeOnCanceled: true,
                onWillDismiss: (SlideActionType type){
                  return false;
                },
              ),
              child: _buildAddressItem(_items[index])
          );
        },
      ),
    );
  }
}
