import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop/common/notification.dart';
import 'package:image_saver/image_saver.dart';

void saveNetworkImage(context,String url) async {
  var response = await http.get(url);
  File savedFile = await ImageSaver.toFile(fileData: response.bodyBytes);
  if(savedFile.existsSync()){
    showToast(context,'图片已保存到相册');
  }else{
    showToast(context, '图片保存失败');
  }
}

