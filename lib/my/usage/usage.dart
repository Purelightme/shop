import 'package:flutter/material.dart';
import 'package:timeline/timeline.dart';
import 'package:timeline/model/timeline_model.dart';

class Usage extends StatefulWidget {
  @override
  _UsageState createState() => _UsageState();
}

class _UsageState extends State<Usage> {

  final List<TimelineModel> list = [
    TimelineModel(
        id: "1",
        description: "浏览商品详情",
        title: "选购"),
    TimelineModel(
        id: "2",
        description: "把心仪的商品加进购物车",
        title: "加购物车"),
    TimelineModel(
        id: "2",
        description: "选好规格，数量，下订单",
        title: "下单"),
    TimelineModel(
        id: "2",
        description: "微信支付宝转账，然后点击'我已付款'",
        title: "付款"),
    TimelineModel(
        id: "2",
        description: "店长收到付款通知，检查订单，确认收款",
        title: "确认收款"),
    TimelineModel(
        id: "2",
        description: "店长返货，给出快递信息",
        title: "发货"),
    TimelineModel(
        id: "2",
        description: "等待快递到手",
        title: "收货"),
    TimelineModel(
        id: "2",
        description: "给出您的评价",
        title: "评价"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物流程'),
      ),
      body: new TimelineComponent(
        timelineList: list,
        // lineColor: Colors.red[200], // Defaults to accent color if not provided
        // backgroundColor: Colors.black87, // Defaults to white if not provided
//         headingColor: Colors.black, // Defaults to black if not provided
        // descriptionColor: Colors.grey, // Defaults to grey if not provided
      )
    );
  }
}
