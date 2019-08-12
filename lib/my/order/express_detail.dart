import 'package:flutter/material.dart';
import 'package:shop/common/canvas/arc.dart';
import 'package:shop/common/canvas/selected_circle.dart';
import 'package:shop/common/common.dart';
import 'package:shop/models/order_detail_model.dart';
import 'package:shop/utils/copy_clipboard.dart';

import 'package:shop/common/canvas/line.dart';


class ExpressDetail extends StatefulWidget {

  ExpressDetail({@required this.expresses,@required this.addressSnapshot});

  Expresses expresses;
  AddressSnapshot addressSnapshot;

  @override
  _ExpressDetailState createState() => _ExpressDetailState();
}

class _ExpressDetailState extends State<ExpressDetail> {

  Widget _buildDetailItem(Detail detail){
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(detail.status,style: TextStyle(
                    color: Colors.green
                ),maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,),
              ),
              Text(detail.time,style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              ),)
            ],
          ),
        ),
        Divider(height: 5,),
      ],
    );
  }

  Widget _buildLeftItem(int index){
    if(index == 0){
      return Column(
        children: <Widget>[
          CustomPaint(
            painter: SelectedCircle(center: Offset(20, 10), radius: 8),
          ),
          CustomPaint(
            painter: Arc(center: Offset(20,10),radius: 3),
          ),
          CustomPaint(
            painter: Line(start: Offset(20,18),end: Offset(20, 80)),
          ),
        ],
      );
    }else{
      return Column(
        children: <Widget>[
          CustomPaint(
            painter: Arc(center: Offset(20,15 + index.toDouble()*65),radius: 6),
          ),
          CustomPaint(
            painter: Line(start: Offset(20,15 + index.toDouble()*65),end: Offset(20, 80 + index.toDouble()*65)),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('物流详情'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 120,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image.network(widget.expresses.productSpecifications[0].imageCover,width: 80,height: 80,),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('配送至：${widget.addressSnapshot.province} ${widget.addressSnapshot.city}'
                        ' ${widget.addressSnapshot.area} ${widget.addressSnapshot.street} \n该包裹共含${widget.expresses.productSpecifications.length}件商品',style: TextStyle(
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
                    Text(widget.expresses.type,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('物流单号：${widget.expresses.expressNo}',style: TextStyle(
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
                      onTap: ()=>copyClipboard(context,widget.expresses.expressNo)
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
                  children: widget.expresses.detail.asMap().map((index,detail){
                    return new MapEntry(index,_buildLeftItem(index));
                  }).values.toList(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    children: widget.expresses.detail.map((Detail detail){
                      return _buildDetailItem(detail);
                    }).toList()
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

