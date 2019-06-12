class ProductDetailModel {
  int errcode;
  String errmsg;
  Data data;

  ProductDetailModel({this.errcode, this.errmsg, this.data});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<String> imgs;
  String longTitle;
  String price;
  int stock;
  int sales;
  String location;
  String expressFee;
  int monthSales;
  int points;
  String guarantee;
  List<String> details;

  Data(
      {this.id,
        this.imageCover,
        this.imgs,
        this.longTitle,
        this.price,
        this.stock,
        this.sales,
        this.location,
        this.expressFee,
        this.monthSales,
        this.points,
        this.guarantee,
        this.details});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageCover = json['image_cover'];
    imgs = json['imgs'].cast<String>();
    longTitle = json['long_title'];
    price = json['price'];
    stock = json['stock'];
    sales = json['sales'];
    location = json['location'];
    expressFee = json['express_fee'];
    monthSales = json['month_sales'];
    points = json['points'];
    guarantee = json['guarantee'];
    details = json['details'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_cover'] = this.imageCover;
    data['imgs'] = this.imgs;
    data['long_title'] = this.longTitle;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['sales'] = this.sales;
    data['location'] = this.location;
    data['express_fee'] = this.expressFee;
    data['month_sales'] = this.monthSales;
    data['points'] = this.points;
    data['guarantee'] = this.guarantee;
    data['details'] = this.details;
    return data;
  }
}
