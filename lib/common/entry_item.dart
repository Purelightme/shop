import 'package:flutter/material.dart';
import 'package:shop/common/touch_callback.dart';

class EntryItem extends StatelessWidget {

  EntryItem({Key key ,@required this.title, this.imagePath, this.icon,this.onPressed})
      :super(key:key);

  final String title;

  final String imagePath;

  final Icon icon;

  final onPressed;

  @override
  Widget build(BuildContext context) {
    return TouchCallback(
      onPressed: onPressed,
      child: Container(
        height: 50.0,
        margin: EdgeInsets.only(left: 22.0,right: 20.0),
        child: Row(
          children: <Widget>[
            Container(
                child: imagePath != null ?
                Image.asset(imagePath,width: 32.0,height: 32.0,) :
                SizedBox(
                  width: 32.0,
                  height: 32.0,
                  child: icon,
                )
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF353535)
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}