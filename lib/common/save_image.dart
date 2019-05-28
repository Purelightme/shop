import 'package:http/http.dart' as http;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:shop/common/notification.dart';

void saveNetworkImage(String url,context) async {
  var response = await http.get(url);
  String result = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
  if (result.startsWith('/')){
    showToast(context,'保存成功');
  }
}

