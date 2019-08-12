import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/category/product/product_list.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/category_model.dart';


class CategoryIndex extends StatefulWidget {

  CategoryIndex({this.initCategoryId});

  int initCategoryId;

  @override
  _CategoryIndexState createState() => _CategoryIndexState();
}

class _CategoryIndexState extends State<CategoryIndex> {

  CategoryModel _categoryModel;
  int _currentId;
  bool _isLoading = true;

  @override
  void initState() {
    http.get(api_prefix+'/categories')
        .then((res){
      setState(() {
        _categoryModel = CategoryModel.fromJson(json.decode(res.body));
        if (widget.initCategoryId == null){
          _currentId = _categoryModel.data.first.id;
        }else{
          _currentId = widget.initCategoryId;
        }
        _isLoading = false;
      });
    });
    super.initState();
  }

  Widget _buildLeftItem(Data first){
    print(first);
    return GestureDetector(
      child: Container(
        color: _currentId == first.id ? Colors.grey.withOpacity(0.2) : Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Text(first.title,style: TextStyle(
          color: _currentId == first.id ? Colors.redAccent : Colors.black
        ),),
      ),
      onTap: (){
        setState(() {
          _currentId = first.id;
        });
      },
    );
  }

  List<Widget> _buildLeft(){
    return _categoryModel.data.map<Widget>((Data data) => _buildLeftItem(data)).toList();
  }

  Widget _buildRightItem(Children children){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16),
          child: Text(children.title),
        ),
        Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: GridView.count(
                  crossAxisCount: 3,
                  physics: new NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
//                crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: children.lastChildren.map<Widget>((LastChildren last) {
                    return TouchCallback(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image.network(last.imageCover, width: 50, height: 50,),
                            Expanded(
                              child: Text(last.title),
                            )
                          ],
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context){
                              return ProductList(categoryId: last.id,);
                            })
                        );
                      },
                    );
                  }).toList()
              )
          ),
      ],
    );
  }

  Widget _buildRight() {

    List<Widget> rights = [];

    rights = _categoryModel.data.where((item){
      return item.id == _currentId;
    }).first.children.map<Widget>(
            (Children children) => _buildRightItem(children)
    ).toList();

    rights.add(Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Center(
        child: Text('---到底了---'),
      ),
    ));

    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: ListView(
          children: rights
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Container() : Container(
      color: Colors.grey.withOpacity(0.2),
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: 80,
            child: ListView(
                children: _buildLeft()
            ),
          ),
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: _buildRight()
              )
          ),
        ],
      ),
    );
  }
}
