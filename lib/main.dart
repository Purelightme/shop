import 'package:flutter/material.dart';
import 'package:shop/routes/route.dart';

import 'authenticate/login.dart';
import 'authenticate/register.dart';
import 'category/category_index.dart';
import 'dynamic/dynamic_index.dart';
import 'index/index.dart';
import 'my/my_index.dart';

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
    new DynamicIndex(),
    new MyIndex()
  ];

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
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.menu,
                    color: _currentIndex == 0 ? Colors.redAccent : Colors.grey),
                title: Text(
                  '首页',
                  style: TextStyle(
                      color:
                          _currentIndex == 0 ? Colors.redAccent : Colors.blue),
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
            BottomNavigationBarItem(
                icon: new Icon(Icons.explore,
                    color: _currentIndex == 2 ? Colors.redAccent : Colors.grey),
                title: Text(
                  '动态',
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
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Login())
                  );
                },
              child: Icon(Icons.palette),
            )
        ),
      ),
    );
  }
}
