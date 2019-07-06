class MessageModel {
  int errcode;
  String errmsg;
  Data data;

  MessageModel({this.errcode, this.errmsg, this.data});

  MessageModel.fromJson(Map<String, dynamic> json) {
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
    nextPageUrl = json['next_page_url'];
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
  String type;
  String content;
  int isReaded;
  Map<String,dynamic> extraData;
  String createdAt;

  Item(
      {this.id,
        this.type,
        this.content,
        this.isReaded,
        this.extraData,
        this.createdAt});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    isReaded = json['is_readed'];
    if(json['extra_data'] != null){
      extraData = json['extra_data'];
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['content'] = this.content;
    data['is_readed'] = this.isReaded;
    if(this.extraData != null){
      data['extra_data'] = this.extraData;
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}
