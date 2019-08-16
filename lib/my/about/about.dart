import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/common/notification.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  String _version = '1.0.0';

  _checkUpdate()async{
    DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
    try{
      IosDeviceInfo _iosInfo = await _deviceInfo.iosInfo;
      print(_iosInfo.model);
      print(_iosInfo.systemName);
      print(_iosInfo.systemVersion);
      print(_iosInfo.name);
    }catch(MissingPluginException) {
      AndroidDeviceInfo _androidInfo = await _deviceInfo.androidInfo;
      print(_androidInfo.brand);
      print(_androidInfo.model);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentVersion();
  }

  _getCurrentVersion()async{
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = _packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext  context) {
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
                child: Text('Version $_version',style: TextStyle(
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
              _checkUpdate();
            },
          ),
          Divider(),
        ],
      )
    );
  }
}
