import 'package:flutter/material.dart';
import 'package:shop/common/constant/color_constant.dart';
import 'package:shop/common/constant/font_const.dart';
import 'package:shop/models/search_result.dart';
import 'package:shop/utils/screen_util.dart';

class SearchResultListWidget extends StatelessWidget {
  final SearchResultListModel list;
  final ValueChanged<String> onItemTap;
  final VoidCallback getNextPage;
  SearchResultListWidget(this.list, {this.onItemTap,this.getNextPage});
  @override
  Widget build(BuildContext context) {
    return list.items.length == 0
        ? Center(
      child: CircularProgressIndicator(),
    )
        : ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: list.items.length,
      itemExtent: 127,
      itemBuilder: (BuildContext context, int i) {
        SearchResultItemModel item = list.items[i];
        if(i==list.items.length){
          getNextPage();
        }
        return Container(
          color: ColorConstant.searchAppBarBgColor,
//          padding: EdgeInsets.only(top: ScreenUtil().L(5), right: ScreenUtil().L(10)),
          child: Row(
            children: <Widget>[
              Image.network(
                item.imageCover,
                width: 120,
                height: 120,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: ColorConstant.divideLineColor))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '￥${item.price}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConstant.priceColor),
                            ),
                          ],
                        ),
                        Text(
                          '好评率${item.commentGreatRate}%',
                          style:
                          FontConstant.searchResultItemCommentCountStyle,
                        ),
                        Text(
                          '销量:${item.sales},库存:${item.stock}',
                          style:
                          FontConstant.searchResultItemCommentCountStyle,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}