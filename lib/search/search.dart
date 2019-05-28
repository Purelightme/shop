import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/search/search_result_list.dart';
import 'package:shop/services/search.dart';
import 'package:shop/widgets/hot_sug.dart';
import 'package:shop/widgets/recomend_list.dart';
import 'package:shop/widgets/topbar.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List hotWords = [];
  List<String> recomendWords = [];
  TextEditingController controller = new TextEditingController();

  void initData() async {
    List querys = await getHotSugs();
    setState(() {
      hotWords = querys;
    });
  }

  onSearchBtTap() {
    if (controller.text.trim().isNotEmpty) {
      goSearchList(controller.text);
    }
  }

  void seachTxtChanged(String q) async {
    var result = await getSuggest(q) as List;
    recomendWords = result.map((dynamic i) {
      List item = i as List;
      return item[0] as String;
    }).toList();
    setState(() {});
  }

  goSearchList(String keyWord) {
    if (keyWord.trim().isNotEmpty) {
      Navigator.push(context,
          CupertinoPageRoute(builder: (BuildContext context) {
            return SearchResultListPage(keyWord);
          }));
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.redAccent,
          leading: SearchTopBarLeadingWidget(),
          actions: <Widget>[
            SearchTopBarActionWidget(
              onActionTap: () => goSearchList(controller.text),
            )
          ],
          elevation: 0,
          titleSpacing: 0,
          title: SearchTopBarTitleWidget(
            seachTxtChanged: seachTxtChanged,
            controller: controller,
          )),
      body: recomendWords.length == 0
          ? HotSugWidget(hotWords:hotWords,goSearchList: goSearchList,)
          : RecommendListWidget(recomendWords, onItemTap: goSearchList),
    );
  }
}
