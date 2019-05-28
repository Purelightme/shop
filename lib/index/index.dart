import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:shop/common/touch_callback.dart';

class Index extends StatefulWidget {
  @override
  _indexState createState() => _indexState();
}

class _indexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            autoPlay: true,
            height: 200.0,
            items: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Image.asset(
                  'images/banners/clothes.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Image.asset(
                  'images/banners/kuzi.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Image.asset(
                  'images/banners/shoes.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Image.asset(
                  'images/banners/watch.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 20, left: 8.0,bottom: 8.0),
                  child: Text(
                    '推荐',
                    style: TextStyle(
                        fontSize: 20.0, color: Colors.deepOrangeAccent),
                  )),
              Container(
                child: GestureDetector(
                  child: Text('搜索'),
                  onTap: (){
                    Navigator.of(context).pushNamed('/search');
                  },
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            padding: EdgeInsets.all(1.0),
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                TouchCallback(
                  child: Stack(
                    children: <Widget>[
                      Image.asset('images/banners/xiezi.jpeg'),
                      Positioned(
                        bottom: 100,
                        right: 100,
                        child: Text('阿迪达斯-A35'),
                      )
                    ],
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return ProductDetail(ProductId: 1,);
                      })
                    );
                  },
                ),
                Stack(
                  children: <Widget>[
                    Image.asset('images/banners/xiezi.jpeg'),
                    Positioned(
                      bottom: 100,
                      right: 100,
                      child: Text('阿迪达斯-A35'),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Image.asset('images/banners/xiezi.jpeg'),
                    Positioned(
                      bottom: 100,
                      right: 100,
                      child: Text('阿迪达斯-A35'),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Image.asset('images/banners/xiezi.jpeg'),
                    Positioned(
                      bottom: 100,
                      right: 100,
                      child: Text('阿迪达斯-A35'),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Image.asset('images/banners/xiezi.jpeg'),
                    Positioned(
                      bottom: 100,
                      right: 100,
                      child: Text('阿迪达斯-A35'),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Image.asset('images/banners/xiezi.jpeg'),
                    Positioned(
                      bottom: 100,
                      right: 100,
                      child: Text('阿迪达斯-A35'),
                    )
                  ],
                ),
              ],
            ),
          ),
//          Expanded(child: Row(
//            children: <Widget>[
//              Container(
//                  margin: EdgeInsets.only(top: 50, left: 60),
//                  child: Text(
//                    '推荐',
//                    style: TextStyle(
//                        fontSize: 20.0, color: Colors.deepOrangeAccent),
//                  )),
//            ],
//          ),),
//          Expanded(child: CustomScrollView(
//            slivers: <Widget>[
//              Container(
//                height: 106,
//                child: Stack(
//                  children: <Widget>[
//                    Image.asset('images/banners/xiezi.jpeg'),
//                    Positioned(
//                      bottom: 100,
//                      right: 100,
//                      child: Text('阿迪达斯-A35'),
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                height: 106,
//                child: Stack(
//                  children: <Widget>[
//                    Image.asset('images/banners/xiezi.jpeg'),
//                    Positioned(
//                      bottom: 100,
//                      right: 100,
//                      child: Text('阿迪达斯-A35'),
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                height: 106,
//                child: Stack(
//                  children: <Widget>[
//                    Image.asset('images/banners/xiezi.jpeg'),
//                    Positioned(
//                      bottom: 100,
//                      right: 100,
//                      child: Text('阿迪达斯-A35'),
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                height: 106,
//                child: Stack(
//                  children: <Widget>[
//                    Image.asset('images/banners/xiezi.jpeg'),
//                    Positioned(
//                      bottom: 100,
//                      right: 100,
//                      child: Text('阿迪达斯-A35'),
//                    )
//                  ],
//                ),
//              ),
//            ],
//          ),)

//          Container(
//            height: 10000,
//            child: ListView(
//              children: <Widget>[
//
//              ],
//            )
//          )

        ],
      ),
    );
  }
}
