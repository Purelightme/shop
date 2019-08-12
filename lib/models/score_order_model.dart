class ScoreOrderModel {
  int errcode;
  String errmsg;
  Data data;

  ScoreOrderModel({this.errcode, this.errmsg, this.data});

  ScoreOrderModel.fromJson(Map<String, dynamic> json) {
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
  int currentPage;
  List<Item> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Item>();
      json['data'].forEach((v) {
        data.add(new Item.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if(json['next_page_url'] != null){
      nextPageUrl = json['next_page_url'];
    }
    path = json['path'];
    perPage = json['per_page'];
    if(json['prev_page_url'] != null){
      prevPageUrl = json['prev_page_url'];
    }
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Item {
  int id;
  ScoreProduct scoreProduct;
  String deliveryInfo;
  int status;
  String statusDesc;
  String failReason;
  String createdAt;
  String updatedAt;

  Item(
      {this.id,
        this.scoreProduct,
        this.deliveryInfo,
        this.status,
        this.statusDesc,
        this.failReason,
        this.createdAt,
        this.updatedAt});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scoreProduct = json['score_product'] != null
        ? new ScoreProduct.fromJson(json['score_product'])
        : null;
    deliveryInfo = json['delivery_info'];
    status = json['status'];
    statusDesc = json['status_desc'];
    failReason = json['fail_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.scoreProduct != null) {
      data['score_product'] = this.scoreProduct.toJson();
    }
    data['delivery_info'] = this.deliveryInfo;
    data['status'] = this.status;
    data['status_desc'] = this.statusDesc;
    data['fail_reason'] = this.failReason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ScoreProduct {
  int id;
  String category;
  String title;
  String imageCover;
  String features;
  int score;
  int stock;
  int sales;

  ScoreProduct(
      {this.id,
        this.category,
        this.title,
        this.imageCover,
        this.features,
        this.score,
        this.stock,
        this.sales});

  ScoreProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    imageCover = json['image_cover'];
    features = json['features'];
    score = json['score'];
    stock = json['stock'];
    sales = json['sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['title'] = this.title;
    data['image_cover'] = this.imageCover;
    data['features'] = this.features;
    data['score'] = this.score;
    data['stock'] = this.stock;
    data['sales'] = this.sales;
    return data;
  }
}
