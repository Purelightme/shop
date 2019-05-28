import 'package:flutter/material.dart';
import 'package:shop/common/constant/color_constant.dart';
import 'package:shop/common/constant/font_const.dart';
import 'package:shop/common/constant/length_const.dart';

class SearchListTopBarTitleWidget extends StatelessWidget {
  final String keyworld;
  SearchListTopBarTitleWidget({Key key, this.keyworld}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: LengthConst.searchTxtFieldHeight,
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.only(right: 30),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: ColorConstant.divideLineColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: ColorConstant.floorTitleColor,
                  size: 20,
                ),
                Text(
                  keyworld,
                  style: FontConstant.defaultStyle,
                ),
              ],
            )));
  }
}