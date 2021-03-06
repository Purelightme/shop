import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/common/common.dart';
import 'package:share_extend/share_extend.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/common_res_model.dart';
import 'package:shop/models/double_specification_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/relate_suggest_model.dart' as suggest;
import 'package:shop/models/single_specification_product_model.dart';
import 'package:shop/utils/token.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'comment_page.dart';
import 'order_check.dart';

class ProductDetail extends StatefulWidget {

  ProductDetail({this.ProductId});

  final int ProductId;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  int _current = 0;

  DoubleSpecificationProductModel _doubleSpecificationProductModel;
  SingleSpecificationProductModel _singleSpecificationProductModel;
  bool _isLoading = true;
  bool _isDoubleSpecification = true;
  int _firstIndex = 0;
  int _secondIndex = 0;
  int _selectedProductSpecification;
  int _number = 1;
  PersistentBottomSheetController bottomSheetController = null;
  suggest.RelateSuggestModel _relateSuggestModel;

  CarouselSlider getFullScreenCarousel(BuildContext mediaContext) {
    return CarouselSlider(
      height: 280,
      autoPlay: false,
      enableInfiniteScroll: false,
      viewportFraction: 1.0,
      aspectRatio: MediaQuery.of(mediaContext).size.aspectRatio,
      items: _doubleSpecificationProductModel.data.imgs.map((url) {
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
        _doubleSpecificationProductModel = DoubleSpecificationProductModel.fromJson(json.decode(res.body));
        if(_doubleSpecificationProductModel.data.specifications[0].children[0].children == null){
          _isDoubleSpecification = false;
          _singleSpecificationProductModel = SingleSpecificationProductModel.fromJson(json.decode(res.body));
        }
      });
    });
    _getRelateSuggest();
  }

  _getRelateSuggest(){
    http.get(api_prefix + '/product/relate-suggests?product_id=${widget.ProductId}').then((res){
      setState(() {
        _relateSuggestModel = suggest.RelateSuggestModel.fromJson(json.decode(res.body));
      });
    });
  }

  List<Widget> _buildSuggest(){
    return _relateSuggestModel.data.map((suggest.Data data){
      return GestureDetector(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.white,
                    width: 1
                ),
                borderRadius: BorderRadius.all(Radius.circular(2))
            ),
            child: Column(
              children: <Widget>[
                Image.network(data.imageCover,height: 50,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(data.shortTitle),
                ),
                Divider(indent: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text('\￥${data.price}',style: TextStyle(
                          color: Colors.redAccent
                      ),),
                    ),
                    data.sellingPoint.isNotEmpty ?
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: data.sellingPoint.split(',').map((str) => Container(
                            margin: EdgeInsets.all(1),
                            child: Text(str,style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 10
                            ),),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent,
                                    width: 1
                                )
                            ),
                            padding: EdgeInsets.all(1),
                          )).toList()
                      ),
                    ) : Container()
                  ],
                )
              ],
            )
        ),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return new ProductDetail(ProductId: data.id,);
          }));
        },
      );
    }).toList();
  }
  
  _buildCommentItem(item){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    foregroundColor: Colors.redAccent,
                    backgroundImage: NetworkImage(item.user.avatar),
                  ),
                ),
                Container(
                  child: Text(item.user.name),
                )
              ],
            ),
            SmoothStarRating(
              allowHalfRating: true,
              onRatingChanged: null,
              starCount: 5,
              rating: item.star.toDouble(),
              size: 20.0,
              color: Colors.redAccent,
              borderColor: Colors.grey,
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(item.createdAt +"   "+ item.specificationString,style: TextStyle(
              color: Colors.grey
          ),),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(item.content,style: TextStyle(
              fontSize: 16
          ),),
        ),
        Divider()
      ],
    );
  }

  Widget _buildComments(){
    return Column(
      children: _doubleSpecificationProductModel.data.comments.comments.map<Widget>((commentItem){
        return _buildCommentItem(commentItem);
      }).toList()
    );
  }

  _close(){
    bottomSheetController.close();
    setState(() {

    });
  }

  _chooseSpecification(context)async {
    bottomSheetController = await showBottomSheet(
        context: context,
        builder: (context){
          return StatefulBuilder(
            builder: (context1, state) {
              return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: _isDoubleSpecification ? MediaQuery
                      .of(context)
                      .size
                      .height - 340 :  MediaQuery
                      .of(context)
                      .size
                      .height - 400,
                    child: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.pinkAccent.withOpacity(0.2),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              _doubleSpecificationProductModel.data
                                                  .imageCover),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('￥${_isDoubleSpecification ?
                                        _doubleSpecificationProductModel.data
                                            .specifications[_firstIndex]
                                            .children[_secondIndex].children[0].price :
                                        _singleSpecificationProductModel.data
                                            .specifications[_firstIndex].children[0]
                                            .price}', style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                        Text('库存${_isDoubleSpecification ?
                                        _doubleSpecificationProductModel.data
                                            .specifications[_firstIndex]
                                            .children[_secondIndex].children[0].stock :
                                        _singleSpecificationProductModel.data
                                            .specifications[_firstIndex].children[0]
                                            .stock}', style: TextStyle(
                                            color: Colors.grey.withOpacity(0.6)
                                        ),),
                                        Text('已选：' + (_isDoubleSpecification ?
                                        _doubleSpecificationProductModel.data
                                            .specifications[_firstIndex].title + ' ' +
                                            _doubleSpecificationProductModel.data
                                                .specifications[_firstIndex]
                                                .children[_secondIndex].title :
                                        _singleSpecificationProductModel.data
                                            .specifications[_firstIndex].title))
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10,top: 10),
                                      child: Icon(Icons.clear,color: Colors.redAccent,),
                                    ),
                                    onTap: (){
                                      _close();
                                    },
                                  )
                                ],
                              ),
                              Divider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildSpecification(state),
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
                                      FlatButton(
                                        child: Icon(Icons.remove, size: 20,),
                                        onPressed: () {
                                          state(() {
                                            if (_number > 1) {
                                              _number--;
                                            }
                                          });
                                        },
                                      ),
                                      Text(_number.toString()),
                                      FlatButton(
                                        child: Icon(Icons.add, size: 20,),
                                        onPressed: () {
                                          state(() {
                                            if (_number < 20) {
                                              _number++;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
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
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 2,
                                    ),
                                    onTap: _addToCart,
                                  ),
                                  GestureDetector(
                                    child: Container(
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
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 2,
                                    ),
                                    onTap: () {
                                      setState(() {

                                      });
                                      _toOrderCheck();
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      )
                    ],
                  )
                );
            },
          );
        }
    );
  }

  List<Widget> _buildSpecification(state){
    if (_isDoubleSpecification){
      state(() {
        _selectedProductSpecification = _doubleSpecificationProductModel.data.specifications[_firstIndex]
            .children[_secondIndex].children[0].id;
      });
      return [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(_doubleSpecificationProductModel.data.specifications[0].rootTitle),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 10,
            children: _doubleSpecificationProductModel.data.specifications.asMap().map((i,DoubleSpecifications item){
              return MapEntry(i,GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                  decoration: BoxDecoration(
                      color: _firstIndex == i ? Colors.deepOrangeAccent : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Text(item.title,style: TextStyle(
                      fontWeight: FontWeight.w100
                  ),),
                ),
                onTap: (){
                  state(() {
                    _firstIndex = i;
                    if(_doubleSpecificationProductModel.data.specifications[_firstIndex].children.length <= _secondIndex){
                      _secondIndex = 0;
                    }
                    _selectedProductSpecification = _doubleSpecificationProductModel.data.specifications[_firstIndex]
                    .children[_secondIndex].children[0].id;
                  });
                },
              ));
            }).values.toList()
          ),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(_doubleSpecificationProductModel.data.specifications[0].children[0].rootTitle),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
              spacing: 10,
              children: _doubleSpecificationProductModel.data.specifications[_firstIndex].children.asMap().map((i,FirstChildren item){
                return MapEntry(i,GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                    decoration: BoxDecoration(
                        color: _secondIndex == i ? Colors.deepOrangeAccent : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Text(item.title,style: TextStyle(
                        fontWeight: FontWeight.w100
                    ),),
                  ),
                  onTap: (){
                    state(() {
                      _secondIndex = i;
                    });
                  },
                ));
              }).values.toList()
          ),
        ),
      ];
    }else{
      state(() {
        _selectedProductSpecification = _singleSpecificationProductModel.data.specifications[_firstIndex]
            .children[0].id;
      });
      return [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(_singleSpecificationProductModel.data.specifications[0].rootTitle),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
              spacing: 10,
              children: _singleSpecificationProductModel.data.specifications.asMap().map((i, SingleSpecifications item) {
                return MapEntry(i,GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                        color: _firstIndex == i ? Colors.deepOrangeAccent : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Text(item.title, style: TextStyle(
                        fontWeight: FontWeight.w100
                    ),),
                  ),
                  onTap: (){
                    state(() {
                      _firstIndex = i;
                      _selectedProductSpecification = _singleSpecificationProductModel.data.specifications[_firstIndex]
                      .children[0].id;
                    });
                  },
                ));
              }).values.toList()
          ),
        )
      ];
    }
  }

  _addToCart()async{
    setState(() {

    });
    String token = await getToken();
    http.post(api_prefix + '/user/shopping_carts',body: {
      'product_specification_id':_selectedProductSpecification.toString(),
      'number':_number.toString()
    },headers: {
      'Authorization':'Bearer ' + token
    }).then((res){
      CommonResModel commonResModel = CommonResModel.fromJson(json.decode(res.body));
      if(commonResModel.errcode != 0){
        showToast(context,commonResModel.errmsg);
      }else{
        showToast(context,'成功加入购物车');
      }
    });
    Navigator.of(context).pop();
  }

  _toOrderCheck(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return OrderCheck(ProductSpecificationId: _selectedProductSpecification,Number: _number,);
    }));
  }

  _toComments(productId){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return new CommentPage(productId: productId,);
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share,color: Colors.white,),
              onPressed: ()async{
                var response =
                ShareExtend.share(
                    '我在一个小店发现了一件好宝贝，分享给你也看看：'+
                        _doubleSpecificationProductModel.data.longTitle +
                        _doubleSpecificationProductModel.data.imageCover,'text');
                if (response == 'success') {
                  print('navigate success');
                }
              },
            ),
        ],
      ),
      body: _isLoading ? Container() : Builder(builder: (context){
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
                                label: Text('${_current+1}/${_doubleSpecificationProductModel.data.imgs.length}')
                            )
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _doubleSpecificationProductModel.data.longTitle,
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
                                    Text('\￥${_doubleSpecificationProductModel.data.price}',style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.redAccent
                                    ),)
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('库存 ${_doubleSpecificationProductModel.data.stock}',style: TextStyle(
                                        fontSize: 10
                                    ),),
                                    SizedBox(width: 10,),
                                    Text('销量 ${_doubleSpecificationProductModel.data.sales}',style: TextStyle(
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
                                        Icon(Icons.location_on,color: Colors.blueAccent.withOpacity(0.5),),
                                        Text(_doubleSpecificationProductModel.data.location),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text('快递：￥${_doubleSpecificationProductModel.data.expressFee}'),
                                  )
                                ],
                              ),
                              Text('月销 ${_doubleSpecificationProductModel.data.monthSales}'),
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
                                              child: Text('购买可得${_doubleSpecificationProductModel.data.points}积分'),
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
                                  child: Text(_doubleSpecificationProductModel.data.guarantee),
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
                                    child: Text(_isDoubleSpecification ?
                                    _doubleSpecificationProductModel.data.specifications[_firstIndex].title + ' ' + _doubleSpecificationProductModel.data.specifications[_firstIndex].children[_secondIndex].title:
                                    _singleSpecificationProductModel.data.specifications[_firstIndex].title),
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
                                Text('宝贝评价(${_doubleSpecificationProductModel.data.comments.total})'),
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Text('查看全部'),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                  onTap: (){
                                    _toComments(widget.ProductId);
                                  },
                                ),
                              ],
                            ),
                          ),
                          _doubleSpecificationProductModel.data.comments.total == 0 ?
                              Container() :
                          _buildComments()
                        ],
                      ),
                    ),
                    commonDivider(),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text('宝贝详情'),
                    ),
                    Column(
                      children: _doubleSpecificationProductModel.data.details.map((url){
                        return Image.network(url,width: MediaQuery.of(context).size.width,);
                      }).toList(),
                    ),
                    commonDivider(),
                    _relateSuggestModel.data.length > 0 ?
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text('相关推荐'),
                    ) : Container(),
                    _relateSuggestModel.data.length > 0 ?
                    Container(
                      padding: EdgeInsets.all(10),
                      child: GridView.count(
                        physics: new NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: _buildSuggest()
                      ),
                    ) : Container(),
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
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Icon(Icons.person,color: Colors.blueAccent,),
                                      Text('客服',style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)
                                      ),)
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.star_border,color: Colors.orangeAccent,),
                                        Text('收藏',style: TextStyle(
                                            color: Colors.black.withOpacity(0.5)
                                        ),)
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.add_shopping_cart,color: Colors.purpleAccent,),
                                        Text('购物车',style: TextStyle(
                                            color: Colors.black.withOpacity(0.5)
                                        ),)
                                      ],
                                    ),
                                    onTap: (){
                                      Navigator.of(context).pushNamed('/cart');
                                    },
                                  )
                                ],
                              ),
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
                                  child: GestureDetector(
                                    child: Center(
                                      child: Text('加入购物车'),
                                    ),
                                    onTap: (){
                                      _chooseSpecification(context);
                                    },
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
                                  child: GestureDetector(
                                    child: Center(
                                      child: Text('立即购买'),
                                    ),
                                    onTap: (){
                                      _chooseSpecification(context);
                                    },
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
      })
    );
  }
}
