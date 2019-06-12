class UserModel {
  int errcode;
  String errmsg;
  Data data;

  UserModel({this.errcode, this.errmsg, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  String email;
  String token;
  String avatar;
  int registerNumber;

  Data(
      {this.id,
        this.name,
        this.email,
        this.token,
        this.avatar,
        this.registerNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    avatar = json['avatar'];
    registerNumber = json['register_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['token'] = this.token;
    data['avatar'] = this.avatar;
    data['register_number'] = this.registerNumber;
    return data;
  }
}
