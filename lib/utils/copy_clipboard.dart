import 'package:flutter/services.dart';
import 'package:shop/common/notification.dart';

copyClipboard(context,text){
  Clipboard.setData(new ClipboardData(text: text)).then((value){
    showToast(context, '复制成功');
  });
}