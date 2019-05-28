import 'package:flutter/material.dart';
import 'package:shop/common/constant/color_constant.dart';

class RecommendListWidget extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onItemTap;
  RecommendListWidget(this.items, {this.onItemTap});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          onTap: () => onItemTap(items[i]),
          child: Container(
            height: 42,
            width: double.infinity,
            // color: Colors.red,
            alignment: Alignment.centerLeft,
            // constraints: BoxConstraints(minWidth: double.infinity),
            child: Text(
              items[i],
              style: TextStyle(fontSize: 15),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Container(
          height: 1,
          color: ColorConstant.searchRecomendDividerColor,
        );
      },
    );
  }
}