class AddressModel {
  int errcode;
  String errmsg;
  List<Data> data;

  AddressModel({this.errcode, this.errmsg, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String province;
  String city;
  String area;
  String areaId;
  String street;
  String name;
  String phone;
  bool isDefault;

  Data(
      {this.id,
        this.province,
        this.city,
        this.area,
        this.areaId,
        this.street,
        this.name,
        this.phone,
        this.isDefault});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    province = json['province'];
    city = json['city'];
    area = json['area'];
    areaId = json['area_id'];
    street = json['street'];
    name = json['name'];
    phone = json['phone'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province'] = this.province;
    data['city'] = this.city;
    data['area'] = this.area;
    data['area_id'] = this.areaId;
    data['street'] = this.street;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['is_default'] = this.isDefault;
    return data;
  }
}
