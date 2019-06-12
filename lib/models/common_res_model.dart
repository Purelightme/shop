class CommonResModel {
  int errcode;
  String errmsg;

  CommonResModel({this.errcode, this.errmsg});

  CommonResModel.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    errmsg = json['errmsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errcode'] = this.errcode;
    data['errmsg'] = this.errmsg;
    return data;
  }
}