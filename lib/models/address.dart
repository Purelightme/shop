class Address {
  String province;
  String city;
  String area;
  String street;
  String name;
  String phone;
  String locationCode;
  bool isDefault;

  Address(
      {this.province,
        this.city,
        this.area,
        this.street,
        this.name,
        this.phone,
        this.locationCode,
        this.isDefault});

  Address.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    city = json['city'];
    area = json['area'];
    street = json['street'];
    name = json['name'];
    phone = json['phone'];
    locationCode = json['location_code'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    data['city'] = this.city;
    data['area'] = this.area;
    data['street'] = this.street;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['location_code'] = this.locationCode;
    data['is_default'] = this.isDefault;
    return data;
  }
}