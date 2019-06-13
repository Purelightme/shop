
import 'package:flutter/material.dart';
import 'package:shop/authenticate/login.dart';
import 'package:shop/authenticate/register.dart';
import 'package:shop/category/category_index.dart';
import 'package:shop/category/product/product_detail.dart';
import 'package:shop/category/product/product_list.dart';
import 'package:shop/my/about/about.dart';
import 'package:shop/my/about/introduction.dart';
import 'package:shop/my/about/store_info.dart';
import 'package:shop/my/cart/cart.dart';
import 'package:shop/my/message/message.dart';
import 'package:shop/my/profile/profile.dart';
import 'package:shop/my/profile/update_nickname.dart';
import 'package:shop/my/receive_address/add_address.dart';
import 'package:shop/my/receive_address/receive_address.dart';
import 'package:shop/my/usage/usage.dart';
import 'package:shop/search/search.dart';
import 'package:shop/category/search/search.dart' as Search2;

final routes = {
  '/cart': (BuildContext context) => Cart(),
  '/receive_address': (BuildContext context) => ReceiveAddress(),
  '/add_address': (BuildContext context) => AddAddress(),
  '/usage': (BuildContext context) => Usage(),
  '/about': (BuildContext context) => About(),
  '/profile': (BuildContext context) => Profile(),
  '/search': (BuildContext context) => Search(),
  '/store_info': (BuildContext context) => StoreInfo(),
  '/introduction': (BuildContext context) => Introduction(),
  '/update_nickname': (BuildContext context) => UpdateNickname(),
  '/product_detail': (BuildContext context) => ProductDetail(),
  '/search2': (BuildContext context) => Search2.Search(),
  '/message': (BuildContext context) => Message(),
  '/category': (BuildContext context) => CategoryIndex(),
  '/login': (BuildContext context) => Login(),
  '/register': (BuildContext context) => Register(),
};