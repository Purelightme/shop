class BannerModel {
  int errcode;
  String errmsg;
  List<Data> data;

  BannerModel({this.errcode, this.errmsg, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  String imageCover;
  var productId;

  Data({this.imageCover, this.productId});

  Data.fromJson(Map<String, dynamic> json) {
    imageCover = json['image_cover'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_cover'] = this.imageCover;
    data['product_id'] = this.productId;
    return data;
  }
}
