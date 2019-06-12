import 'package:flutter/material.dart';
import 'package:shop/common/canvas/arc.dart';
import 'package:shop/common/canvas/circle.dart';
import 'package:shop/common/canvas/selected_circle.dart';
import 'package:shop/common/common.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:shop/utils/copy_clipboard.dart';

import 'package:shop/common/canvas/line.dart';


class ExpressDetail extends StatefulWidget {
  @override
  _ExpressDetailState createState() => _ExpressDetailState();
}

class _ExpressDetailState extends State<ExpressDetail> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('物流详情'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image.asset('images/banners/shoes.jpeg',width: 80,height: 80,),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('配送至：湖北省 武汉市 洪山区 江城雅居T2江城雅居T2',style: TextStyle(
                        fontSize: 16
                    ),maxLines: 10,softWrap: true,),
                  ),
                )
              ],
            ),
          ),
          commonDivider(),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('物流公司：',style: TextStyle(
                        color: Colors.black.withOpacity(0.6)
                    ),),
                    Text('顺丰快递',)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('物流单号：23867654235096',style: TextStyle(
                        color: Colors.black.withOpacity(0.6)
                    ),),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(2))
                        ),
                        child: Text('复制',style: TextStyle(
                          color: Colors.blue,
                          fontSize: 9
                        ),),
                      ),
                      onTap: ()=>copyClipboard(context,'测试复制文本')
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomPaint(
                      painter: SelectedCircle(center: Offset(20, 10), radius: 5),
                    ),
                    CustomPaint(
                      painter: Arc(center: Offset(20,10),radius: 6),
                    ),
                    CustomPaint(
                      painter: Line(start: Offset(20,20),end: Offset(20, 80)),
                    ),
                    CustomPaint(
                      painter: Circle(center: Offset(20, 90),radius: 5),
                    ),
                    CustomPaint(
                      painter: Line(start: Offset(20,100),end: Offset(20, 160)),
                    ),
                    CustomPaint(
                      painter: Circle(center: Offset(20, 170),radius: 5),
                    ),
                    CustomPaint(
                      painter: Line(start: Offset(20,180),end: Offset(20, 240)),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('签收'),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text('已签收，签收人凭取货码签收,已签收，签收人凭取货码签收,已签收，签收人凭取货码签收',style: TextStyle(
                                  color: Colors.green
                              ),maxLines: 3,softWrap: true,),
                            ),
                            Text('2019-09-08 18:00:09',style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('签收'),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text('已签收，签收人凭取货码签收,已签收，签收人凭取货码签收,已签收，签收人凭取货码签收',style: TextStyle(
                                  color: Colors.green
                              ),maxLines: 3,softWrap: true,),
                            ),
                            Text('2019-09-08 18:00:09',style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('签收'),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text('已签收，签收人凭取货码签收.',style: TextStyle(
                                  color: Colors.green
                              ),maxLines: 3,softWrap: true,),
                            ),
                            Text('2019-09-08 18:00:09',style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('签收'),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text('已签收，签收人凭取货码签收,已签收，签收人凭取货码签收,已签收，签收人凭取货码签收',style: TextStyle(
                                  color: Colors.green
                              ),maxLines: 3,softWrap: true,),
                            ),
                            Text('2019-09-08 18:00:09',style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('签收'),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text('已签收，签收人凭取货码签收,已签收，签收人凭取货码签收,已签收，签收人凭取货码签收',style: TextStyle(
                                  color: Colors.green
                              ),maxLines: 3,softWrap: true,),
                            ),
                            Text('2019-09-08 18:00:09',style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('签收'),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text('已签收，签收人凭取货码签收,已签收，签收人凭取货码签收,已签收，签收人凭取货码签收',style: TextStyle(
                                  color: Colors.green
                              ),maxLines: 3,softWrap: true,),
                            ),
                            Text('2019-09-08 18:00:09',style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

