import 'package:flutter/material.dart';
import 'package:shop/common/save_image.dart';
import 'package:shop/common/touch_callback.dart';
import 'package:cached_network_image/cached_network_image.dart';


class StoreInfo extends StatefulWidget {
  @override
  _StoreInfoState createState() => _StoreInfoState();
}

class _StoreInfoState extends State<StoreInfo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('店长信息'),
      ),
      body: Center(
        child: Container(
          child: PageView(
            children: <Widget>[
              TouchCallback(
                  child: CachedNetworkImage(
                    imageUrl: "http://via.placeholder.com/350x150",
                    placeholder: (context,
                        url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  onPressed: () {},
                  onLongPressed: () {
//                    showDialog(
//                        context: context,
//                        builder: (_) =>
//                            NetworkGiffyDialog(
//                                image: Image.network(
//                                    'http://b.hiphotos.baidu.com/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg'),
//                                title: Text('是否保存到相册？',
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                        fontSize: 22.0,
//                                        fontWeight: FontWeight.w600)),
//                                description: Text(
//                                  '你的酒馆对我打了烊，请告诉我今后怎么抗，遍体鳞伤，还笑着原谅',
//                                  textAlign: TextAlign.center,
//                                ),
//                                onOkButtonPressed: () {
//                                  saveNetworkImage(
//                                    context,
//                                    'http://b.hiphotos.baidu.com/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg',
//                                  );
//                                  Navigator.of(context).pop();
//                                }
//                            )
//                    );
                  }
              ),
              Image.network('https://ws1.sinaimg.cn/large/0065oQSqly1fw8wzdua6rj30sg0yc7gp.jpg'),
              Image.network('https://ws1.sinaimg.cn/large/0065oQSqly1fw0vdlg6xcj30j60mzdk7.jpg'),
              Image.network('https://ws1.sinaimg.cn/large/0065oQSqly1fuo54a6p0uj30sg0zdqnf.jpg'),
              Image.network('https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg'),
            ],
          ),
//          width: 200,
//          height: 200,
        ),
      ),
    );
  }
}
