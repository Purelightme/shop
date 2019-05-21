import 'package:flutter/material.dart';

class MyIndex extends StatefulWidget {
  @override
  _MyIndexState createState() => _MyIndexState();
}

class _MyIndexState extends State<MyIndex> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Purelightme'),
            CircleAvatar(
              child: Image.asset('images/banners/clothes.jpeg'),
            )
          ],
        ),
        ListTile(
          leading: Icon(Icons.card_travel),
          title: Text('购物车'),
        ),
        ListTile(
          leading: Icon(Icons.card_travel),
          title: Text('购物车'),
        ),
        ListTile(
          leading: Icon(Icons.card_travel),
          title: Text('购物车'),
        ),
        ListTile(
          leading: Icon(Icons.card_travel),
          title: Text('购物车'),
        ),
        ListTile(
          leading: Icon(Icons.card_travel),
          title: Text('购物车'),
        ),
        ListTile(
          leading: Icon(Icons.card_travel),
          title: Text('购物车'),
        ),
        ListTile(
          leading: Icon(Icons.card_travel),
          title: Text('购物车'),
        ),
        ListTile(
          leading: Icon(Icons.card_travel),
          title: Text('购物车'),
        ),
      ],
    );
  }
}
