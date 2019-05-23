
import 'package:flutter/material.dart';
import 'package:shop/my/about/about.dart';
import 'package:shop/my/cart/cart.dart';
import 'package:shop/my/profile/profile.dart';
import 'package:shop/my/receive_address/add_address.dart';
import 'package:shop/my/receive_address/receive_address.dart';
import 'package:shop/my/usage/usage.dart';

final routes = {
  '/cart': (BuildContext context) => Cart(),
  '/receive_address': (BuildContext context) => ReceiveAddress(),
  '/add_address': (BuildContext context) => AddAddress(),
  '/usage': (BuildContext context) => Usage(),
  '/about': (BuildContext context) => About(),
  '/profile': (BuildContext context) => Profile(),


};