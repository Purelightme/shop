class OrderDetailModel {
  int errcode;
  String errmsg;
  Data data;

  OrderDetailModel({this.errcode, this.errmsg, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
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
  String orderNo;
  List<SpecificationSnapshot> specificationSnapshot;
  AddressSnapshot addressSnapshot;
  String payTime;
  String receiveTime;
  String amount;
  int status;
  String statusDesc;
  String canceledBy;
  String expressFee;
  List<Expresses> expresses;
  String createdAt;

  Data(
      {this.id,
        this.orderNo,
        this.specificationSnapshot,
        this.addressSnapshot,
        this.payTime,
        this.receiveTime,
        this.amount,
        this.status,
        this.statusDesc,
        this.canceledBy,
        this.expressFee,
        this.expresses,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    if (json['specification_snapshot'] != null) {
      specificationSnapshot = new List<SpecificationSnapshot>();
      json['specification_snapshot'].forEach((v) {
        specificationSnapshot.add(new SpecificationSnapshot.fromJson(v));
      });
    }
    addressSnapshot = json['address_snapshot'] != null
        ? new AddressSnapshot.fromJson(json['address_snapshot'])
        : null;
    payTime = json['pay_time'];
    receiveTime = json['receive_time'];
    amount = json['amount'];
    status = json['status'];
    statusDesc = json['status_desc'];
    canceledBy = json['canceled_by'];
    expressFee = json['express_fee'];
    if (json['expresses'] != null) {
      expresses = new List<Expresses>();
      json['expresses'].forEach((v) {
        expresses.add(new Expresses.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    if (this.specificationSnapshot != null) {
      data['specification_snapshot'] =
          this.specificationSnapshot.map((v) => v.toJson()).toList();
    }
    if (this.addressSnapshot != null) {
      data['address_snapshot'] = this.addressSnapshot.toJson();
    }
    data['pay_time'] = this.payTime;
    data['receive_time'] = this.receiveTime;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['status_desc'] = this.statusDesc;
    data['canceled_by'] = this.canceledBy;
    data['express_fee'] = this.expressFee;
    if (this.expresses != null) {
      data['expresses'] = this.expresses.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
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

class AddressSnapshot {
  int id;
  String area;
  String city;
  String name;
  String phone;
  String street;
  String areaId;
  int userId;
  String province;
  String createdAt;
  Null deletedAt;
  int isDefault;
  String updatedAt;

  AddressSnapshot(
      {this.id,
        this.area,
        this.city,
        this.name,
        this.phone,
        this.street,
        this.areaId,
        this.userId,
        this.province,
        this.createdAt,
        this.deletedAt,
        this.isDefault,
        this.updatedAt});

  AddressSnapshot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'];
    city = json['city'];
    name = json['name'];
    phone = json['phone'];
    street = json['street'];
    areaId = json['area_id'];
    userId = json['user_id'];
    province = json['province'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    isDefault = json['is_default'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area'] = this.area;
    data['city'] = this.city;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['area_id'] = this.areaId;
    data['user_id'] = this.userId;
    data['province'] = this.province;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['is_default'] = this.isDefault;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Expresses {
  int id;
  List<ProductSpecifications> productSpecifications;
  String type;
  String expressNo;
  List<Detail> detail;
  String status;
  String createdAt;

  Expresses(
      {this.id,
        this.productSpecifications,
        this.type,
        this.expressNo,
        this.detail,
        this.status,
        this.createdAt});

  Expresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_specifications'] != null) {
      productSpecifications = new List<ProductSpecifications>();
      json['product_specifications'].forEach((v) {
        productSpecifications.add(new ProductSpecifications.fromJson(v));
      });
    }
    type = json['type'];
    expressNo = json['express_no'];
    if (json['detail'] != null) {
      detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productSpecifications != null) {
      data['product_specifications'] =
          this.productSpecifications.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['express_no'] = this.expressNo;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductSpecifications {
  String price;
  String number;
  String longTitle;
  int productId;
  String imageCover;
  String specificationString;
  int productSpecificationId;

  ProductSpecifications(
      {this.price,
        this.number,
        this.longTitle,
        this.productId,
        this.imageCover,
        this.specificationString,
        this.productSpecificationId});

  ProductSpecifications.fromJson(Map<String, dynamic> json) {
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

class Detail {
  String time;
  String status;

  Detail({this.time, this.status});

  Detail.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['status'] = this.status;
    return data;
  }
}
