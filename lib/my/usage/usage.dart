import 'package:flutter/material.dart';

class Usage extends StatefulWidget {
  @override
  _UsageState createState() => _UsageState();
}

class _UsageState extends State<Usage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物流程'),
      ),
      body: ListView(
        children: <Widget>[
          Text('1,浏览商品'),
          Text('2,加入购物车'),
          Text('3,下单'),
          Text('4,联系转账'),
          Text('5,发货'),
          Text('6,确认收货'),
          Text('7,评价'),
        ],
      ),
    );
  }
}
