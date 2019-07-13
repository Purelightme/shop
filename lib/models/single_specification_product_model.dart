class SingleSpecificationProductModel {
  int errcode;
  String errmsg;
  Data data;

  SingleSpecificationProductModel({this.errcode, this.errmsg, this.data});

  SingleSpecificationProductModel.fromJson(Map<String, dynamic> json) {
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
  List<SingleSpecifications> specifications;
  Comments comments;

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
        this.specifications,
        this.comments});

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
      specifications = new List<SingleSpecifications>();
      json['specifications'].forEach((v) {
        specifications.add(new SingleSpecifications.fromJson(v));
      });
    }
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
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
    if (this.comments != null) {
      data['comments'] = this.comments.toJson();
    }
    return data;
  }
}

class SingleSpecifications {
  String title;
  int sort;
  String rootTitle;
  List<Children> children;

  SingleSpecifications({this.title, this.sort, this.rootTitle, this.children});

  SingleSpecifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sort = json['sort'];
    rootTitle = json['root_title'];
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
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

class Children {
  int id;
  int productId;
  String price;
  int stock;

  Children({this.id, this.productId, this.price, this.stock});

  Children.fromJson(Map<String, dynamic> json) {
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

class Comments {
  int total;
  List<CommentItem> comments;

  Comments({this.total, this.comments});

  Comments.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['comments'] != null) {
      comments = new List<CommentItem>();
      json['comments'].forEach((v) {
        comments.add(new CommentItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentItem {
  User user;
  String content;
  int star;
  String specificationString;
  String createdAt;

  CommentItem(
      {this.user,
        this.content,
        this.star,
        this.specificationString,
        this.createdAt});

  CommentItem.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    content = json['content'];
    star = json['star'];
    specificationString = json['specification_string'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['content'] = this.content;
    data['star'] = this.star;
    data['specification_string'] = this.specificationString;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class User {
  String name;
  String avatar;

  User({this.name, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}