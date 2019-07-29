class OrderListModel {
  int errcode;
  String errmsg;
  Data data;

  OrderListModel({this.errcode, this.errmsg, this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
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
    if(json['last_page'] != null){
      lastPage = json['last_page'];
    }
    lastPageUrl = json['last_page_url'];
    if(json['next_page_url'] != null){
      nextPageUrl = json['next_page_url'];
    }
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
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
  String orderNo;
  int status;
  String statusDesc;
  List<SpecificationSnapshot> specificationSnapshot;
  String amount;
  int productNumber;
  String expressFee;

  Item(
      {this.id,
        this.orderNo,
        this.status,
        this.statusDesc,
        this.specificationSnapshot,
        this.amount,
        this.productNumber,
        this.expressFee});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    status = json['status'];
    statusDesc = json['status_desc'];
    if (json['specification_snapshot'] != null) {
      specificationSnapshot = new List<SpecificationSnapshot>();
      json['specification_snapshot'].forEach((v) {
        specificationSnapshot.add(new SpecificationSnapshot.fromJson(v));
      });
    }
    amount = json['amount'];
    productNumber = json['product_number'];
    expressFee = json['express_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['status_desc'] = this.statusDesc;
    if (this.specificationSnapshot != null) {
      data['specification_snapshot'] =
          this.specificationSnapshot.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['product_number'] = this.productNumber;
    data['express_fee'] = this.expressFee;
    return data;
  }
}

class SpecificationSnapshot {
  String price;
  String number;
  String longTitle;
  int productId;
  String imageCover;
  String specificationString;
  int productSpecificationId;

  SpecificationSnapshot(
      {this.price,
        this.number,
        this.longTitle,
        this.productId,
        this.imageCover,
        this.specificationString,
        this.productSpecificationId});

  SpecificationSnapshot.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    number = json['number'];
    longTitle = json['long_title'];
    productId = json['product_id'];
    imageCover = json['image_cover'];
    specificationString = json['specification_string'];
    productSpecificationId = json['product_specification_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['number'] = this.number;
    data['long_title'] = this.longTitle;
    data['product_id'] = this.productId;
    data['image_cover'] = this.imageCover;
    data['specification_string'] = this.specificationString;
    data['product_specification_id'] = this.productSpecificationId;
    return data;
  }
}
