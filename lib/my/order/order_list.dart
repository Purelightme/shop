import 'package:flutter/material.dart';
import 'order_list_tab_view_item.dart';

class OrderList extends StatefulWidget {

  OrderList({@required this.initIndex});

  int initIndex;

  @override
  _OrderListState createState() => _OrderListState();
}

class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('全部',style: TextStyle(color: Colors.grey),), body: OrderListTabViewItem(status: -1,)),
  _TabData(tab: Text('待付款',style: TextStyle(color: Colors.grey),), body: OrderListTabViewItem(status: 1,)),
  _TabData(tab: Text('待发货',style: TextStyle(color: Colors.grey),), body: OrderListTabViewItem(status: 3,)),
  _TabData(tab: Text('待收货',style: TextStyle(color: Colors.grey),), body: OrderListTabViewItem(status: 4,)),
  _TabData(tab: Text('待评价',style: TextStyle(color: Colors.grey),), body: OrderListTabViewItem(status: 5,)),
  _TabData(tab: Text('已评价',style: TextStyle(color: Colors.grey),), body: OrderListTabViewItem(status: 6,))
];

class _OrderListState extends State<OrderList> {

  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: DefaultTabController(
        length: tabBarList.length,
        initialIndex: widget.initIndex,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10,top: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: TextStyle(fontSize: 18),
                      labelColor: Colors.redAccent,
                      labelStyle: TextStyle(fontSize: 18),
                      tabs: tabBarList
                  ),
                  Divider(),
                ],
              )
            ),
            Expanded(
                child: TabBarView(
                  children: tabBarViewList,
                )
            )
          ],
        ),
      ),
    );
  }
}
