class DoubleSpecificationProductModel {
  int errcode;
  String errmsg;
  Data data;

  DoubleSpecificationProductModel({this.errcode, this.errmsg, this.data});

  DoubleSpecificationProductModel.fromJson(Map<String, dynamic> json) {
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
  List<DoubleSpecifications> specifications;

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
        this.details,
        this.specifications});

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
    if (json['specifications'] != null) {
      specifications = new List<DoubleSpecifications>();
      json['specifications'].forEach((v) {
        specifications.add(new DoubleSpecifications.fromJson(v));
      });
    }
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
    if (this.specifications != null) {
      data['specifications'] =
          this.specifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoubleSpecifications {
  String title;
  int sort;
  String rootTitle;
  List<FirstChildren> children;

  DoubleSpecifications({this.title, this.sort, this.rootTitle, this.children});

  DoubleSpecifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sort = json['sort'];
    rootTitle = json['root_title'];
    if (json['children'] != null) {
      children = new List<FirstChildren>();
      json['children'].forEach((v) {
        children.add(new FirstChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sort'] = this.sort;
    data['root_title'] = this.rootTitle;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FirstChildren {
  String title;
  int sort;
  String rootTitle;
  List<SecondChildren> children;

  FirstChildren({this.title, this.sort, this.rootTitle, this.children});

  FirstChildren.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sort = json['sort'];
    rootTitle = json['root_title'];
    if (json['children'] != null) {
      children = new List<SecondChildren>();
      json['children'].forEach((v) {
        children.add(new SecondChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sort'] = this.sort;
    data['root_title'] = this.rootTitle;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecondChildren {
  int id;
  int productId;
  String price;
  int stock;

  SecondChildren({this.id, this.productId, this.price, this.stock});

  SecondChildren.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['stock'] = this.stock;
    return data;
  }
}
