import 'package:flutter/material.dart';
import 'package:shop/models/search_result.dart';
import 'package:shop/services/search.dart';
import 'package:shop/widgets/search_list_top_bar.dart';
import 'package:shop/widgets/search_result_list.dart';
import 'package:shop/widgets/topbar.dart';

class SearchResultListPage extends StatefulWidget {
  final String keyword;

  SearchResultListPage(this.keyword);

  @override
  State<StatefulWidget> createState() => SearchResultListState();
}

class SearchResultListState extends State<SearchResultListPage> {
  SearchResultListModel listData = SearchResultListModel(items: []);
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Color(0xFFFFFFFF),
            leading: SearchTopBarLeadingWidget(),
            //  actions: <Widget>[SearchTopBarActionWidget()],
            elevation: 0,
            titleSpacing: 0,
            title: SearchListTopBarTitleWidget(keyworld: widget.keyword)),
        body: SearchResultListWidget(listData,
            getNextPage: () => getSearchList(widget.keyword)));
  }

  void getSearchList(String keyword) {
    var data = getSearchResult(keyword, page++);
    SearchResultListModel list = SearchResultListModel.fromJson(data);
    setState(() {
      listData.items.addAll(list.items);
    });
  }

  @override
  void initState() {
    getSearchList(widget.keyword);
    print(111);
    print(listData.items.length);
    super.initState();
  }
}
