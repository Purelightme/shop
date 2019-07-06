class ProductSpecificationModel {
  int errcode;
  String errmsg;
  Data data;

  ProductSpecificationModel({this.errcode, this.errmsg, this.data});

  ProductSpecificationModel.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    errmsg = json['errmsg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errcode'] = this.errcode;
    data['errmsg'] = this.errmsg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String imageCover;
  String longTitle;
  String specificationString;
  String price;
  String expressFee;

  Data(
      {this.id,
        this.imageCover,
        this.longTitle,
        this.specificationString,
        this.price,
        this.expressFee});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageCover = json['image_cover'];
    longTitle = json['long_title'];
    specificationString = json['specification_string'];
    price = json['price'];
    expressFee = json['express_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_cover'] = this.imageCover;
    data['long_title'] = this.longTitle;
    data['specification_string'] = this.specificationString;
    data['price'] = this.price;
    data['express_fee'] = this.expressFee;
    return data;
  }
}
