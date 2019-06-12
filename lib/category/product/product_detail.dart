import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/common.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:shop/models/product_detail_model.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {

  ProductDetail({this.ProductId});

  final int ProductId;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  int _current = 0;

  ProductDetailModel _productDetailModel;
  bool _isLoading = true;
  bool _isChoosing = false;

  CarouselSlider getFullScreenCarousel(BuildContext mediaContext) {
    return CarouselSlider(
      height: 280,
      autoPlay: false,
      enableInfiniteScroll: false,
      viewportFraction: 1.0,
      aspectRatio: MediaQuery.of(mediaContext).size.aspectRatio,
      items: _productDetailModel.data.imgs.map((url) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: 1000,
              ),
            ),
          );
        },
      ).toList(),
      onPageChanged: (index){
        setState(() {
          _current= index;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    http.get(api_prefix + '/products/${widget.ProductId}').then((res){
      setState(() {
        _isLoading = false;
        _productDetailModel = ProductDetailModel.fromJson(json.decode(res.body));
      });
    });
  }

  int _firstSpecification;

  _setFirstSpecification(int index){
    return _firstSpecification = index;
  }

  _chooseSpecification(context) {
    setState(() {
      _isChoosing = true;
    });
    showModalBottomSheet(
        context: context,
        builder: (context) =>
            GestureDetector(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(20),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    _productDetailModel.data.imageCover),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('￥9.99', style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500
                              ),),
                              Text('库存209', style: TextStyle(
                                  color: Colors.grey.withOpacity(0.6)
                              ),),
                              Text('已选：蓝色 L')
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text('颜色分类'),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 10,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Text('蓝色',style: TextStyle(
                              fontWeight: FontWeight.w100
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Text('蓝色'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Text('红色'),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('尺寸'),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 10,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Text('M'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Text('L'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Text('XL'),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('购买数量'),
                        ),
                        Row(
                          children: <Widget>[
                            RaisedButton(
                              child: Icon(Icons.add),
                              onPressed: (){},
                            ),
                            RaisedButton(
                              child: Text('1'),
                              onPressed: null,
                            ),
                            Container(
                              child: RaisedButton(
                                child: Icon(Icons.add),
                                onPressed: (){},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.yellowAccent,
                                Colors.orangeAccent
                              ]),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)
                              )
                          ),
                          child: Center(
                            child: Text('加入购物车'),
                          ),
                          width: MediaQuery.of(context).size.width/2,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.orange,
                                Colors.redAccent
                              ]),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)
                              )
                          ),
                          child: Center(
                            child: Text('立即购买'),
                          ),
                          width: MediaQuery.of(context).size.width/2,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              onTap: (){
                return false;
              },
            )
    ).then((val) {
      setState(() {
        _isChoosing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
      ),
      body: _isLoading ? Container() : Builder(builder: (context){
        if (_isChoosing){
          return Opacity(
            opacity: 0.6,
            child: Container(
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                          getFullScreenCarousel(context),
                          Positioned(
                              top: 230.0,
                              right: 20.0,
                              child: Chip(
                                  backgroundColor: Colors.grey[600].withOpacity(0.1),
                                  label: Text('${_current+1}/${_productDetailModel.data.imgs.length}')
                              )
                          ),
                          Positioned(
                            child: IconButton(
                              icon: Icon(Icons.share),
                              onPressed: ()async{
                                print(111);
                                var response =
                                await FlutterShareMe().shareToSystem(msg: 'Hello Flutter');
                                if (response == 'success') {
                                  print('navigate success');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _productDetailModel.data.longTitle,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text('售价：',style: TextStyle(
                                          fontSize: 10
                                      ),),
                                      Text('\￥${_productDetailModel.data.price}',style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.redAccent
                                      ),)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('库存 ${_productDetailModel.data.stock}',style: TextStyle(
                                          fontSize: 10
                                      ),),
                                      SizedBox(width: 10,),
                                      Text('销量 ${_productDetailModel.data.sales}',style: TextStyle(
                                        fontSize: 10,

                                      ),)
                                    ],
                                  )


                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      commonDivider(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text('发货',style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.location_on,color: Colors.transparent.withOpacity(0.5),),
                                          Text(_productDetailModel.data.location),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text('快递:${_productDetailModel.data.expressFee}'),
                                    )
                                  ],
                                ),
                                Text('月销 ${_productDetailModel.data.monthSales}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('优惠',style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
//                                      Row(
//                                        children: <Widget>[
//                                          Container(
//                                            child: Text('活动直降', style: TextStyle(
//                                                color: Colors.deepOrange,
//                                                fontSize: 8
//                                            ),),
//                                            decoration: BoxDecoration(
//                                                border: Border.all(
//                                                    width: 1,
//                                                    color: Colors.orangeAccent.withOpacity(0.1)
//                                                ),
//                                                borderRadius: BorderRadius.all(Radius.circular(20)),
//                                                color: Colors.deepOrange.withOpacity(0.1)
//                                            ),
//                                          ),
//                                          Container(
//                                            padding: EdgeInsets.all(10),
//                                            child: Text('\$5',style: TextStyle(
//                                                color: Colors.redAccent
//                                            ),),
//                                          )
//                                        ],
//                                      ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Text('积分奖励', style: TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontSize: 8
                                                ),),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.orangeAccent.withOpacity(0.1)
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    color: Colors.deepOrange.withOpacity(0.1)
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text('购买可得${_productDetailModel.data.points}积分'),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
//                            Container(
//                              padding: EdgeInsets.all(10),
//                              child: Row(
//                                children: <Widget>[
//                                  Text('查看活动'),
//                                  Icon(Icons.arrow_forward_ios)
//                                ],
//                              ),
//                            )
                              ],
                            )
                          ],
                        ),
                      ),
                      commonDivider(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Text('保障',style: TextStyle(
                                      color: Colors.grey
                                  ),),
                                  Container(
                                    margin: EdgeInsets.only(left: 30),
                                    child: Text(_productDetailModel.data.guarantee),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      commonDivider(),
                      GestureDetector(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    Text('选择',style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text('选择规格'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          return _chooseSpecification(context);
                        },
                      ),
                      commonDivider(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('宝贝评价(5)'),
                                  GestureDetector(
                                    child: Row(
                                      children: <Widget>[
                                        Text('查看全部'),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: AssetImage('images/banners/xiezi.jpeg'),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text('张三'),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text('产品非常好'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: AssetImage('images/banners/xiezi.jpeg'),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text('张三'),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text('产品非常好'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      commonDivider(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text('宝贝详情'),
                      ),
                      Column(
                        children: _productDetailModel.data.details.map((url){
                          return Image.network(url);
                        }).toList(),
                      ),
                      commonDivider(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text('相关推荐'),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: GridView.count(
                          physics: new NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: <Widget>[
                            Container(
                              height: 100,
                              color: Colors.redAccent,
                            ),
                            Container(
                              height: 100,
                              color: Colors.blueGrey,
                            ),
                            Container(
                              height: 100,
                              color: Colors.pink,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(color: Colors.grey)
                            )
                        ),
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Icon(Icons.menu),
                                      Text('客服')
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.star_border),
                                        Text('收藏')
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(Icons.add_shopping_cart),
                                      Text('购物车')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10,left: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.yellowAccent,
                                          Colors.orangeAccent
                                        ]),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)
                                        )
                                    ),
                                    child: Center(
                                      child: Text('加入购物车'),
                                    ),
                                    width: 100,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.orange,
                                          Colors.redAccent
                                        ]),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20)
                                        )
                                    ),
                                    child: Center(
                                      child: Text('立即购买'),
                                    ),
                                    width: 100,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        }else{
          return Container(
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        getFullScreenCarousel(context),
                        Positioned(
                            top: 230.0,
                            right: 20.0,
                            child: Chip(
                                backgroundColor: Colors.grey[600].withOpacity(0.1),
                                label: Text('${_current+1}/${_productDetailModel.data.imgs.length}')
                            )
                        ),
                        Positioned(
                          child: IconButton(
                            icon: Icon(Icons.share),
                            onPressed: ()async{
                              print(111);
                              var response =
                              await FlutterShareMe().shareToSystem(msg: 'Hello Flutter');
                              if (response == 'success') {
                                print('navigate success');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _productDetailModel.data.longTitle,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('售价：',style: TextStyle(
                                        fontSize: 10
                                    ),),
                                    Text('\￥${_productDetailModel.data.price}',style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.redAccent
                                    ),)
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('库存 ${_productDetailModel.data.stock}',style: TextStyle(
                                        fontSize: 10
                                    ),),
                                    SizedBox(width: 10,),
                                    Text('销量 ${_productDetailModel.data.sales}',style: TextStyle(
                                      fontSize: 10,

                                    ),)
                                  ],
                                )


                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    commonDivider(),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text('发货',style: TextStyle(
                                      color: Colors.grey
                                  ),),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.location_on,color: Colors.transparent.withOpacity(0.5),),
                                        Text(_productDetailModel.data.location),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text('快递:${_productDetailModel.data.expressFee}'),
                                  )
                                ],
                              ),
                              Text('月销 ${_productDetailModel.data.monthSales}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('优惠',style: TextStyle(
                                      color: Colors.grey
                                  ),),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
//                                      Row(
//                                        children: <Widget>[
//                                          Container(
//                                            child: Text('活动直降', style: TextStyle(
//                                                color: Colors.deepOrange,
//                                                fontSize: 8
//                                            ),),
//                                            decoration: BoxDecoration(
//                                                border: Border.all(
//                                                    width: 1,
//                                                    color: Colors.orangeAccent.withOpacity(0.1)
//                                                ),
//                                                borderRadius: BorderRadius.all(Radius.circular(20)),
//                                                color: Colors.deepOrange.withOpacity(0.1)
//                                            ),
//                                          ),
//                                          Container(
//                                            padding: EdgeInsets.all(10),
//                                            child: Text('\$5',style: TextStyle(
//                                                color: Colors.redAccent
//                                            ),),
//                                          )
//                                        ],
//                                      ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: Text('积分奖励', style: TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontSize: 8
                                              ),),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.orangeAccent.withOpacity(0.1)
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  color: Colors.deepOrange.withOpacity(0.1)
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              child: Text('购买可得${_productDetailModel.data.points}积分'),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
//                            Container(
//                              padding: EdgeInsets.all(10),
//                              child: Row(
//                                children: <Widget>[
//                                  Text('查看活动'),
//                                  Icon(Icons.arrow_forward_ios)
//                                ],
//                              ),
//                            )
                            ],
                          )
                        ],
                      ),
                    ),
                    commonDivider(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Text('保障',style: TextStyle(
                                    color: Colors.grey
                                ),),
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(_productDetailModel.data.guarantee),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    commonDivider(),
                    GestureDetector(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Text('选择',style: TextStyle(
                                      color: Colors.grey
                                  ),),
                                  Container(
                                    margin: EdgeInsets.only(left: 30),
                                    child: Text('选择规格'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        return _chooseSpecification(context);
                      },
                    ),
                    commonDivider(),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('宝贝评价(5)'),
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Text('查看全部'),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage: AssetImage('images/banners/xiezi.jpeg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text('张三'),
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('产品非常好'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage: AssetImage('images/banners/xiezi.jpeg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text('张三'),
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('产品非常好'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    commonDivider(),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text('宝贝详情'),
                    ),
                    Column(
                      children: _productDetailModel.data.details.map((url){
                        return Image.network(url);
                      }).toList(),
                    ),
                    commonDivider(),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text('相关推荐'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: GridView.count(
                        physics: new NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: <Widget>[
                          Container(
                            height: 100,
                            color: Colors.redAccent,
                          ),
                          Container(
                            height: 100,
                            color: Colors.blueGrey,
                          ),
                          Container(
                            height: 100,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(color: Colors.grey)
                          )
                      ),
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.menu),
                                    Text('客服')
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.star_border),
                                      Text('收藏')
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.add_shopping_cart),
                                    Text('购物车')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10,left: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.yellowAccent,
                                        Colors.orangeAccent
                                      ]),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)
                                      )
                                  ),
                                  child: Center(
                                    child: Text('加入购物车'),
                                  ),
                                  width: 100,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.orange,
                                        Colors.redAccent
                                      ]),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)
                                      )
                                  ),
                                  child: Center(
                                    child: Text('立即购买'),
                                  ),
                                  width: 100,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          );
        }
      })
    );
  }
}
