import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

void showToast(context, String msg, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity);
}

void showSnackBar(context,content){
  Scaffold.of(context).showSnackBar(SnackBar(content: content));
}