class SearchResultItemModel {
  String title;
  String imageCover;
  double price;
  int sales;
  String commentGreatRate;
  int stock;

  SearchResultItemModel(
      {this.title,
        this.imageCover,
        this.price,
        this.sales,
        this.commentGreatRate,
        this.stock});

  SearchResultItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageCover = json['image_cover'];
    price = json['price'];
    sales = json['sales'];
    commentGreatRate = json['comment_great_rate'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image_cover'] = this.imageCover;
    data['price'] = this.price;
    data['sales'] = this.sales;
    data['comment_great_rate'] = this.commentGreatRate;
    data['stock'] = this.stock;
    return data;
  }
}


class SearchResultListModel {
  List<SearchResultItemModel> items;

  SearchResultListModel({this.items});

  factory SearchResultListModel.fromJson(List items){
    return SearchResultListModel(
        items: items.map((i){
          return SearchResultItemModel.fromJson(i);
        }).toList()
    );
  }
}
