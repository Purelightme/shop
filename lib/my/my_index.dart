import 'package:flutter/material.dart';
import 'package:shop/common/entry_item.dart';
import 'package:shop/common/touch_callback.dart';

class MyIndex extends StatefulWidget {
  @override
  _MyIndexState createState() => _MyIndexState();
}

class _MyIndexState extends State<MyIndex> {

  Column _buildOrderItem(IconData icon,String text){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon,color: Colors.black54,),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(text,style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.black
          ),),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          height: 80.0,
          child: TouchCallback(
            onPressed: (){
              Navigator.of(context).pushNamed('/profile');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12.0,right: 15.0),
                  child: Image.asset('images/banners/clothes.jpeg',width: 70.0,height: 70.0,),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Purelightme',style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF353535)
                      ),),
                      Text('你是小店第13位顾客',style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFa9a9a9)
                      ),)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12.0,right: 15.0),
                  child: Image.asset('images/banners/clothes.jpeg',width: 24.0,height: 24.0,),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 100.0,
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildOrderItem(Icons.menu,'全部订单'),
              _buildOrderItem(Icons.payment, '待付款'),
              _buildOrderItem(Icons.flight, '待收货'),
              _buildOrderItem(Icons.insert_comment, '待评价'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              EntryItem(
                icon: Icon(Icons.shopping_cart),
                title: '购物车',
                onPressed: (){
                  Navigator.of(context).pushNamed('/cart');
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Divider(
                  height: 0.5,
                  color: Color(0xFFd9d9d9),
                ),
              ),
              EntryItem(
                icon: Icon(Icons.recent_actors),
                title: '收货地址',
                onPressed: (){
                  Navigator.of(context).pushNamed('/receive_address');
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Divider(
                  height: 0.5,
                  color: Color(0xFFd9d9d9),
                ),
              ),
              EntryItem(
                icon: Icon(Icons.data_usage),
                title: '购物流程',
                onPressed: (){
                  Navigator.of(context).pushNamed('/usage');
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Divider(
                  height: 0.5,
                  color: Color(0xFFd9d9d9),
                ),
              ),
              EntryItem(
                icon: Icon(Icons.help),
                title: '关于小店',
                onPressed: (){
                  Navigator.of(context).pushNamed('/about');
                },
              )
            ],
          ),
        ),

      ],
    );
  }
}
