class IntroduceModel {
  int errcode;
  String errmsg;
  Data data;

  IntroduceModel({this.errcode, this.errmsg, this.data});

  IntroduceModel.fromJson(Map<String, dynamic> json) {
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
  String introduce;

  Data({this.introduce});

  Data.fromJson(Map<String, dynamic> json) {
    introduce = json['introduce'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['introduce'] = this.introduce;
    return data;
  }
}
