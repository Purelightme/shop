import 'package:flutter/material.dart';
import 'package:shop/common/constant/color_constant.dart';
import 'package:shop/common/constant/string_constant.dart';
import 'package:shop/utils/util.dart';

class HotSugWidget extends StatelessWidget {
  final List hotWords;
  final ValueChanged<String> goSearchList;
  HotSugWidget( {Key key,this.hotWords,this.goSearchList}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          color: ColorConstant.divideLineColor,
          child: Text(StringConstant.searchHotTxt),
          margin: EdgeInsets.only(bottom: 10),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: hotWords
              .map((i) => GestureDetector(
            onTap: ()=>goSearchList(i),
            child: Container(
                decoration: BoxDecoration(
                    color: randomColor(),
                    borderRadius: BorderRadius.circular(5)),
                padding:
                EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                child: Text(
                  i,
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                )),
          ))
              .toList(),
        )
      ],
    );
  }
}
