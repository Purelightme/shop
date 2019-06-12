import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:shop/common/notification.dart';

copyClipboard(context,text){
  ClipboardManager.copyToClipBoard(text).then((result) {
    showToast(context,'复制成功');
  });
}