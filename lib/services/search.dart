
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getHotSugs() async {
  var url = 'https://suggest.taobao.com/sug?area=sug_hot&wireless=2';
  var res = await http.get(url);
  if (res.statusCode == 200) {
    List querys = jsonDecode(res.body)['querys'] as List;
    return querys;
  }else{
    return [];
  }
}



Future getSuggest(String q) async {
  String url = 'https://suggest.taobao.com/sug?q=$q&code=utf-8&area=c2c';
  var res = await http.get(url);
  if(res.statusCode==200){
    List data = jsonDecode(res.body)['result'] as List;
    return data;
  }else{
    return [];
  }
}

getSearchResult(String keyworld,[int page=0]){
//  String  url = 'https://so.m.jd.com/ware/search._m2wq_list?keyword=$keyworld&datatype=1&callback=C&page=$page&pagesize=10&ext_attr=no&brand_col=no&price_col=no&color_col=no&size_col=no&ext_attr_sort=no&merge_sku=yes&multi_suppliers=yes&area_ids=1,72,2818&qp_disable=no&fdesc=%E5%8C%97%E4%BA%AC';
//  var res = await http.get(url);
//  String body = res.body;
//  String jsonString = body.substring(2,body.length-2);

  var jsonString = '''
  {"data":[{
  "title":"夏季韩版男裤橘黄色七分裤1",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
  {
  "title":"夏季韩版男裤橘黄色七分裤2",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
 {
  "title":"夏季韩版男裤橘黄色七分裤",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
 {
  "title":"夏季韩版男裤橘黄色七分裤",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
 {
  "title":"夏季韩版男裤橘黄色七分裤",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
 {
  "title":"夏季韩版男裤橘黄色七分裤",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
 {
  "title":"夏季韩版男裤橘黄色七分裤",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
 {
  "title":"夏季韩版男裤橘黄色七分裤",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
 {
  "title":"夏季韩版男裤橘黄色七分裤",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
},
 {
  "title":"夏季韩版男裤橘黄色七分裤",
  "image_cover":"http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg",
  "price":99.98,
  "stock":108,
  "sales":20,
  "comment_great_rate":"98%"  
}
]}
  ''';

  var json = jsonDecode(jsonString.replaceAll( RegExp(r'\\x..') ,'/'));
  return  json['data'] as List;
}