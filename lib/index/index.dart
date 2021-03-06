import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop/api/api.dart';
import 'package:shop/category/category_index.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:http/http.dart' as http;
import 'package:shop/category/product/product_list.dart';
import 'package:shop/category/search/search.dart';
import 'package:shop/common/common.dart';
import 'package:shop/common/notification.dart';
import 'package:shop/models/banner_model.dart' as bm;
import 'package:shop/models/index_category.dart' as ic;
import 'package:shop/models/hot_product_model.dart' as hp;
import 'package:shop/models/index_suggest_model.dart' as index_suggest;
import 'package:shop/utils/token.dart';

class Index extends StatefulWidget {
  @override
  _indexState createState() => _indexState();
}

class _indexState extends State<Index> {

  bm.BannerModel _bannerModel;

  List<hp.Data> _hots = [];

  List<index_suggest.Item> _iterms = [];
  bool _hasMore = true;
  int _page = 0;
  
  ic.IndexCategory _indexCategory;

  _fetchNextPageIndexSuggest()async{
    if(!_hasMore){
      showToast(context,'没有更多啦~');
      return;
    }
    setState(() {
      _page++;
    });
    String token = await getToken();
    if(token.isNotEmpty){
      http.get(api_prefix + '/product/index-suggests?page=$_page',headers: {
        'Authorization':'Bearer $token'
      }).then((res){
        index_suggest.IndexSuggestModel _indexSuggestModel = index_suggest.IndexSuggestModel.fromJson(json.decode(res.body));
        if(_indexSuggestModel.data.perPage > _indexSuggestModel.data.data.length){
          setState(() {
            _hasMore = false;
            _iterms.addAll(_indexSuggestModel.data.data);
          });
        }else{
          setState(() {
            _hasMore = true;
            _iterms.addAll(_indexSuggestModel.data.data);
          });
        }
      });
    }else{
      http.get(api_prefix + '/product/index-suggests?page=$_page').then((res){
        index_suggest.IndexSuggestModel _indexSuggestModel = index_suggest.IndexSuggestModel.fromJson(json.decode(res.body));
        if(_indexSuggestModel.data.perPage > _indexSuggestModel.data.data.length){
          setState(() {
            _hasMore = false;
            _iterms.addAll(_indexSuggestModel.data.data);
          });
        }else{
          setState(() {
            _hasMore = true;
            _iterms.addAll(_indexSuggestModel.data.data);
          });
        }
      });
    }
  }

  ScrollController _scrollController = new ScrollController();
  TextEditingController _controller = new TextEditingController();

  Widget _buildHotItem(hp.Data data) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 5),
      child: GestureDetector(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(data.imageCover, fit: BoxFit.cover,height: 160,),
              Expanded(
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Text(data.shortTitle,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return ProductDetail(ProductId: data.id,);
                          }));
                    },
                  )
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ProductDetail(ProductId: 1,);
              })
          );
        },
      ),
    );
  }

  Widget _buildSuggestItem(index_suggest.Item item){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.grey.withOpacity(0.1)
                )
            )
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 150,
              child: Image.network(item.imageCover,fit: BoxFit.cover,),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width-180,
                  child: Text(item.longTitle,softWrap: true,maxLines: 2,overflow: TextOverflow.ellipsis,),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('￥${item.price}',style: TextStyle(
                      fontSize: 20,
                      color: Colors.redAccent
                  ),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width-180,
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          child: Expanded(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 40,
                                  child: Stack(
                                    children: <Widget>[
                                      item.buyers.avatars.length > 0 ?
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.redAccent,
                                            backgroundImage: NetworkImage(item.buyers.avatars[0])),
                                      ) : Container(),
                                      item.buyers.avatars.length > 1 ?
                                      Positioned(
                                        left: 10,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: CircleAvatar(
                                              foregroundColor: Colors.redAccent,
                                              backgroundImage: NetworkImage(item.buyers.avatars[1])),
                                        ),
                                      ) : Container(),
                                      item.buyers.avatars.length > 2 ?
                                      Positioned(
                                        left: 20,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: CircleAvatar(
                                              foregroundColor: Colors.redAccent,
                                              backgroundImage: NetworkImage(item.buyers.avatars[2])),
                                        ),
                                      ) : Container(),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(item.buyers.total > 0 ? item.buyers.total.toString() + '人已购买' : 
                                    '等你来买呀', style: TextStyle(
                                      color: Colors.grey
                                  ),),
                                )
                              ],
                            ),
                          )
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              border: Border.all(
                                  color: Colors.redAccent
                              )
                          ),
                          child: Text('去购买', style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ProductDetail(ProductId: item.id,);
        }));
      },
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 3,left: 10,bottom: 3),
          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.redAccent.withOpacity(0.3),
                  width: 2
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white
          ),
          width: MediaQuery.of(context).size.width-50,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Icon(Icons.search, color: Colors.pinkAccent,
                  size: 20,),
              ),
              Expanded(
                child: TextField(
                  enabled: false,
                  controller: _controller,
                  onSubmitted: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: '',
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          padding: EdgeInsets.all(5),
          child: Text('搜索',style: TextStyle(
            color: Colors.pinkAccent
          ),),
        )
      ],
    );
  }

  Widget _buildCategoryItem(ic.Data data){
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Image.network(data.imageCover,height: 60,),
          Text(data.title)
        ],
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return new ProductList(categoryId: data.id,);
          })
        );
      },
    );
  }

  Widget _buildBannerItem(bm.Data data){
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Image.network(data.imageCover,height: 100,),
      ),
      onTap: (){
        if(data.productId != null){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return new ProductDetail(ProductId: data.productId);
            })
          );
        }
      },
    );
  }

  List<Widget> _buildCategory() {
    var categories = _indexCategory.data.map(
            (ic.Data data) => _buildCategoryItem(data)
    ).toList();
    categories.add(GestureDetector(
      child: Column(
        children: <Widget>[
          Image.asset('images/banners/xiezi.jpeg'),
          Text('所有分类')
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return Scaffold(
              appBar: AppBar(
                title: Text('分类'),
              ),
              body: CategoryIndex(),
            );
          })
        );
      },
    )
    );
    return categories;
  }

  @override
  void initState() {
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchNextPageIndexSuggest();
      }
    });
    //获取banners
    http.get(api_prefix+'/banners')
    .then((res){
      setState(() {
        _bannerModel = bm.BannerModel.fromJson(json.decode(res.body));
      });
    });
    //获取categories
    http.get(api_prefix+'/category/index_show_categories')
    .then((res){
      setState(() {
        _indexCategory = ic.IndexCategory.fromJson(json.decode(res.body));
      });
    });
    //获取热门商品
    http.get(api_prefix+'/product/hots')
    .then((res){
      setState(() {
        _hots = hp.HotProductModel.fromJson(json.decode(res.body)).data;
      });
    });
    super.initState();
    _fetchNextPageIndexSuggest();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        controller: _scrollController,
        children: <Widget>[

          //Banner
          _bannerModel != null ?
          CarouselSlider(
            autoPlay: true,
            height: 200.0,
            items:
            _bannerModel.data.map((data)=>_buildBannerItem(data)).toList()
          ) : Container(
            height: 200,
          ),

          //搜索框
          GestureDetector(
            child: Container(
              color: Colors.redAccent.withOpacity(0.3),
              child: Column(
                children: <Widget>[
                  _buildSearchBar(),
                ],
              ),
            ),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
//                  return new ProductList(isAutoFocus: true);
                return new Search();
                })
              );
            },
          ),

          //分类
          _indexCategory != null ?
          Container(
            height: 200,
            padding: EdgeInsets.all(10),
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              physics: NeverScrollableScrollPhysics(),
              children: _buildCategory()
            ),
          ) : Container(
            height: 200,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 10, left: 8.0,bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.whatshot,color: Colors.redAccent,),
                      Text(
                        '热卖',
                        style: TextStyle(
                            fontSize: 18.0, color: Colors.deepOrangeAccent),
                      ),
                    ],
                  )
              ),
            ],
          ),
          _hots.length > 0 ?
          Container(
            padding: EdgeInsets.all(1.0),
            height: 190,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _hots.map((data) => _buildHotItem(data)).toList()
            ),
          ) : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 10, left: 8.0,bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.palette,color: Colors.redAccent,),
                      Text(
                        '推荐',
                        style: TextStyle(
                            fontSize: 18.0, color: Colors.deepOrangeAccent),
                      ),
                    ],
                  )
              ),
            ],
          ),
          Column(
            children: _iterms.map((item) => _buildSuggestItem(item)).toList()
          )
        ],
      ),
    );
  }
}
