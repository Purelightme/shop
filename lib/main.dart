import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop/routes/route.dart';
import 'package:shop/score/score_index.dart';
import 'category/category_index.dart';
import 'index/index.dart';
import 'my/my_index.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    new Index(),
    new CategoryIndex(),
//    new ActivityIndex(),
    new ScoreIndex(),
    new MyIndex()
  ];

  @override
  void initState() {
    super.initState();
    _uploadDeviceInfo();
  }

  _uploadDeviceInfo()async{
//    Directory appDocDir = await getApplicationDocumentsDirectory();
//    String dir = appDocDir.path;
//    final file = new File('$dir/device.txt');
//    if(!file.existsSync()){
//      //上传设备信息
//
//      //创建文件
//      file.createSync();
//    }
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          primarySwatch: Colors.red,
        ),
        routes: routes,
        home: Scaffold(
          appBar: AppBar(
            title: Text('一个小店'),
            actions: <Widget>[
//              IconButton(icon: Icon(Icons.delete_forever), onPressed: ()async{
//                SharedPreferences prefs = await SharedPreferences.getInstance();
//                prefs.remove('token');
//              })
            ],
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: new Icon(Icons.menu,
                      color: _currentIndex == 0 ? Colors.redAccent : Colors.grey),
                  title: Text(
                    '首页',
                    style: TextStyle(
                        color:
                        _currentIndex == 0 ? Colors.redAccent : Colors.black),
                  )),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.search,
                      color: _currentIndex == 1 ? Colors.redAccent : Colors.grey),
                  title: Text(
                    '分类',
                    style: TextStyle(
                        color:
                        _currentIndex == 1 ? Colors.redAccent : Colors.black),
                  )),
//              BottomNavigationBarItem(
//                  icon: new Icon(Icons.explore,
//                      color: _currentIndex == 2 ? Colors.redAccent : Colors.grey),
//                  title: Text(
//                    '活动',
//                    style: TextStyle(
//                        color:
//                        _currentIndex == 2 ? Colors.redAccent : Colors.black),
//                  )),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.explore,
                      color: _currentIndex == 2 ? Colors.redAccent : Colors.grey),
                  title: Text(
                    '积分商城',
                    style: TextStyle(
                        color:
                        _currentIndex == 2 ? Colors.redAccent : Colors.black),
                  )),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.person,
                      color: _currentIndex == 3 ? Colors.redAccent : Colors.grey),
                  title: Text(
                    '我的',
                    style: TextStyle(
                        color:
                        _currentIndex == 3 ? Colors.redAccent : Colors.black),
                  )),
            ],
          ),
        ),
      );
  }
}
