import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget commonDivider(){
  return SizedBox(
    height: 10,
    child: Container(
      color: Colors.grey.withOpacity(0.2),
    ),
  );
}

Widget cachedImage(String url,context){
  return CachedNetworkImage(
    imageUrl: url,
    errorWidget: (context,url,error) => Icon(Icons.error),
  );
}