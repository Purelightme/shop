import 'package:flutter/material.dart';

Widget commonDivider({num opacity = 0.2}){
  return SizedBox(
    height: 10,
    child: Container(
      color: Colors.grey.withOpacity(opacity),
    ),
  );
}