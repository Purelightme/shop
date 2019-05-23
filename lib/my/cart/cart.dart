import 'package:flutter/material.dart';
import 'package:shop/models/cart_product.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<CartProduct> items = List.generate(10, (i){
    return new CartProduct(imageCover: 'https://static.laravelacademy.org/wp-content/uploads/2017/09/logo.png',
    title: '商品$i',
      specification: '颜色：红色，尺寸：30英寸',
      price: '20.0',
      num: i
    );
  });
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.position);
//      print(_scrollController.position.maxScrollExtent);
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<int> newEntries = await fakeRequest(items.length, items.length); //returns empty list
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge -offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
//        items.addAll();
        isPerformingRequest = false;
      });
    }
  }

  Future<List<int>> fakeRequest(int from, int to) async {
    return Future.delayed(Duration(seconds: 2), () {
      return List.generate(to - from, (i) => i + from);
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildProduct(CartProduct product){
    return
      Container(
//        height: 100,
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
                  Text(product.title,style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF353535)
                  ),),
                  Text(product.specification,style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFFa9a9a9)
                  ),),
                  Text('\$'+product.price,style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.red
                  ),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12.0,right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                  ),
                  Text(product.num.toString(),style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.redAccent
                  ),),
                  IconButton(
                    icon: Icon(Icons.remove),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的购物车'),
      ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      if (index == items.length) {
                        return _buildProgressIndicator();
                      } else {
                        return _buildProduct(items[index]);
                      }
                    }
                )
            ),
            Row(
              children: <Widget>[
                Checkbox(value: true, onChanged: null),
                Text('全选'),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "不含运费 ",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        Text(
                          "合计:",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        Text(
                          "￥",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        Text(
                          "\$100",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: new Text(
                            "结算(\$200)",
                            style: TextStyle(color: Colors.white),
                          ),
                          width: 130,
                          height: 50,
                          color: Colors.red,
                        )

                      ],
                    )
                ),
              ],
            ),
          ],
        )
    );
  }
}
