import 'package:flutter/material.dart';

import 'color_constant.dart';

class FontConstant {
  static TextStyle defaultStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
    decoration: TextDecoration.none,
  );
  static TextStyle fLoorTitleStyle = TextStyle(
    fontSize: 16.0,
    color: ColorConstant.floorTitleColor,
  );
  static TextStyle pinweiCorverSubtitleStyle = TextStyle(
    fontSize: 13.0,
    color: ColorConstant.pinweicorverSubtitleColor,
  );

  static TextStyle cartBottomTotalPriceStyle = TextStyle(fontSize: 18,color: ColorConstant.priceColor);


  static TextStyle searchResultItemCommentCountStyle = TextStyle(
      fontSize: 12, color: Color(0xFF999999));

}