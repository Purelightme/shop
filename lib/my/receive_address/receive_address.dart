import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/address.dart';

class ReceiveAddress extends StatefulWidget {
  @override
  _ReceiveAddressState createState() => _ReceiveAddressState();
}

class _ReceiveAddressState extends State<ReceiveAddress> {

  @override
  void initState() {
    super.initState();
  }

  Widget _buildAddressItem(Address address){
    return Container(
//      height: 100,
      padding: EdgeInsets.only(left: 30.0,top: 20,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Baseline(
                    baseline: 0.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(address.name,style: TextStyle(
                        fontSize: 18.0
                    ),),
                  ),
                  Baseline(
                      baseline: 0.0,
                      baselineType: TextBaseline.alphabetic,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(address.phone,style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey
                        ),),
                      )
                  ),
                ],
              ),
              Text('${address.province} ${address.city} ${address.area}'),
              Text(address.street),
            ],
          ),
          Expanded(
            child: Icon(Icons.lens),
          )
        ],
      )
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
      body: ListView.builder(
        itemCount: 100,
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
                  showToast(context, index.toString());
                },
              ),
              IconSlideAction(
                caption: '删除',
                color: Colors.red,
                icon: Icons.delete,
                onTap: (){
                  showToast(context, index.toString());
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
            child: _buildAddressItem(new Address(
              province: '湖北省',
              city: '武汉市',
              area: '洪山区',
              street: '现代光谷世贸中心F1098',
              name: '张三$index',
              phone: '16601126819',
              locationCode: '10003',
              isDefault: true,
            ))
          );
        },
      ),
    );
  }
}
