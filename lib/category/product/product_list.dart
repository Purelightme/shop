import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop/common/touch_callback.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTop() {
    return Container(
        height: 40,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text('综合'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('销量'),
            ),
            Container(
//                        padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('价格'),
                  ),
                  Container(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.arrow_drop_up, size: 20,),
                        Icon(Icons.arrow_drop_down, size: 20,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('分类'),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.redAccent,
            leading: BackButton(),
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text('搜索'),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/product_detail');
                },
              )
            ],
            elevation: 0,
            titleSpacing: 0,
            title: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 2
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search, color: Color.fromRGBO(51, 51, 51, 1),
                    size: 20,),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          hintText: '搜一搜',
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
//        body: Row(
//            children: <Widget>[
////              Container(
////                height: 40,
////                color: Colors.green,
////                child: Row(
////                  mainAxisAlignment: MainAxisAlignment.spaceAround,
////                  crossAxisAlignment: CrossAxisAlignment.start,
////                  children: <Widget>[
////                    Container(
////                      padding: EdgeInsets.all(10),
////                      child: Text('综合'),
////                    ),
////                    Container(
////                      padding: EdgeInsets.all(10),
////                      child: Text('销量'),
////                    ),
////                    Container(
//////                        padding: EdgeInsets.all(10),
////                      child: Row(
////                        children: <Widget>[
////                          Container(
////                            padding: EdgeInsets.all(10),
////                            child: Text('价格'),
////                          ),
////                          Container(
////                            height: 40,
////                            child: Column(
////                              crossAxisAlignment: CrossAxisAlignment.start,
////                              children: <Widget>[
////                                Icon(Icons.arrow_drop_up, size: 20,),
////                                Icon(Icons.arrow_drop_down, size: 20,)
////                              ],
////                            ),
////                          )
////                        ],
////                      ),
////                    ),
////                    Container(
////                      padding: EdgeInsets.all(10),
////                      child: Text('分类'),
////                    ),
////                  ],
////                ),
////              ),
//
//            ],
//          )
    body: Stack(
      children: <Widget>[
        Positioned(
          left: 0.001,
          child: _buildTop(),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: StaggeredGridView.countBuilder(
            primary: false,
            crossAxisCount: 4,
            itemCount: 21,
            itemBuilder: (BuildContext context, int index) => TouchCallback(
              child: Container(
                  color: Colors.green,
                  child: new Center(
                    child: new CircleAvatar(
                      backgroundColor: Colors.white,
                      child: new Text('$index'),
                    ),
                  )
              ),
              onPressed: (){
                Navigator.of(context).pushNamed('/product_detail');
              },
            ),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ),
      ],
    )
    );
  }
}







