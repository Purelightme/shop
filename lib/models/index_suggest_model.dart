class IndexSuggestModel {
  int errcode;
  String errmsg;
  Data data;

  IndexSuggestModel({this.errcode, this.errmsg, this.data});

  IndexSuggestModel.fromJson(Map<String, dynamic> json) {
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
  String imageCover;
  String longTitle;
  String price;
  Buyers buyers;

  Item({this.id, this.imageCover, this.longTitle, this.price, this.buyers});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageCover = json['image_cover'];
    longTitle = json['long_title'];
    price = json['price'];
    buyers =
    json['buyers'] != null ? new Buyers.fromJson(json['buyers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_cover'] = this.imageCover;
    data['long_title'] = this.longTitle;
    data['price'] = this.price;
    if (this.buyers != null) {
      data['buyers'] = this.buyers.toJson();
    }
    return data;
  }
}

class Buyers {
  int total;
  List<String> avatars;

  Buyers({this.total, this.avatars});

  Buyers.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    avatars = json['avatars'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['avatars'] = this.avatars;
    return data;
  }
}
