import 'package:flutter/material.dart';

import 'activity_detail.dart';

class ActivityIndex extends StatefulWidget {
  @override
  _ActivityIndexState createState() => _ActivityIndexState();
}

class _ActivityIndexState extends State<ActivityIndex> {
  Widget _buildItem() {
    return GestureDetector(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('images/banners/xiezi.jpeg'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Baseline(
                              baseline: 16,
                              baselineType: TextBaseline.alphabetic,
                              child: Text('六一钜惠',style: TextStyle(
                                  fontSize: 22
                              ),),
                            ),
                            Baseline(
                              baseline: 16,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(' 共29件商品参与7折优惠',style: TextStyle(
                                  fontSize: 12
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          width: 200,
                          child: Text('61儿童节服装折扣即将开始，打破底价就是现在',
                            softWrap: true,overflow: TextOverflow.ellipsis,)
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('待开始'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ActivityDetail())
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RefreshIndicator(
          child: ListView(
            children: <Widget>[
              _buildItem(),
              _buildItem(),
            ],
          ),
          onRefresh: (){
            Future.delayed(Duration(seconds: 1)).then((res){
              return [1,2];
            });
          },
        )
      ),
    );
  }
}
