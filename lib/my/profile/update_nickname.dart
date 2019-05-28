import 'package:flutter/material.dart';

class UpdateNickname extends StatefulWidget {
  @override
  _UpdateNicknameState createState() => _UpdateNicknameState();
}

class _UpdateNicknameState extends State<UpdateNickname> {

  final TextEditingController _controller = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改昵称'),
        centerTitle: true,
      ),
//      body: Row(
//        children: <Widget>[
//          TextField(
//            controller: _controller,
//            decoration: new InputDecoration(
//              hintText: 'Purelightme',
//            ),
//          ),
//          Text('2-10个字符，可由中英文，数字，"_"，"-"组成')
//        ],
//      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new TextField(
          autofocus: true,
          controller: _controller,
          decoration: new InputDecoration(
            hintText: 'Purelightme',
//            border: OutlineInputBorder(
//
//            )
          ),
        ),
        Container(
          width: 10,
          height: 10,
        ),
        new SizedBox(
          width: 340,
          height: 42,
          child: RaisedButton(
            onPressed: () {
              showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text('What you typed'),
                  content: new Text(_controller.text),
                ),
              );
            },
            color: Colors.redAccent,
            child: Text('确定',style: TextStyle(
                fontSize: 18,
                color: Colors.white
            ),),
          ),
        ),
      ],
    )
    );
  }
}
