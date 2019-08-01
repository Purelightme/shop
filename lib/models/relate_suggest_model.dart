class RelateSuggestModel {
  int errcode;
  String errmsg;
  List<Data> data;

  RelateSuggestModel({this.errcode, this.errmsg, this.data});

  RelateSuggestModel.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    errmsg = json['errmsg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errcode'] = this.errcode;
    data['errmsg'] = this.errmsg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String imageCover;
  String shortTitle;
  String price;
  String sellingPoint;

  Data(
      {this.id,
        this.imageCover,
        this.shortTitle,
        this.price,
        this.sellingPoint});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageCover = json['image_cover'];
    shortTitle = json['short_title'];
    price = json['price'];
    sellingPoint = json['selling_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_cover'] = this.imageCover;
    data['short_title'] = this.shortTitle;
    data['price'] = this.price;
    data['selling_point'] = this.sellingPoint;
    return data;
  }
}
