import 'package:flutter/material.dart';
import 'package:shop/common/notification.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于小店'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 120),
            child: Image.asset('images/banners/xiezi.jpeg',width: 100,
              height: 100,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: Text('方小店FangStore App',style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
                ),),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text('Version 1.0.0',style: TextStyle(
                  fontSize: 16.0
                ),),
              )
            ],
          ),
          Divider(),
          ListTile(
            title: Text('小店简介'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              Navigator.of(context).pushNamed('/introduction');
            },
          ),
          Divider(),
          ListTile(
            title: Text('店长信息'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              Navigator.of(context).pushNamed('/store_info');
            },
          ),
          Divider(),
          ListTile(
            title: Text('检查新版本'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              showToast(context,'已是最新版本');
            },
          ),
          Divider(),
        ],
      )
    );
  }
}
