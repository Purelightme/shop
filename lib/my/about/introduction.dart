import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/api/api.dart';
import 'package:shop/models/introduce_model.dart';
import 'package:http/http.dart' as http;

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {

  IntroduceModel _introduceModel;

  @override
  void initState() {
    http.get(api_prefix+'/settings').then((res){
      setState(() {
        _introduceModel = IntroduceModel.fromJson(json.decode(res.body));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('小店简介'),
      ),
      body: _introduceModel == null ? Center(
        child: RefreshProgressIndicator(),
      ) : ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(32.0),
            child: Text('''
            ${_introduceModel.data.introduce}
            ''',
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
