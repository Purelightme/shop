class BadgeModel {
  int errcode;
  String errmsg;
  Data data;

  BadgeModel({this.errcode, this.errmsg, this.data});

  BadgeModel.fromJson(Map<String, dynamic> json) {
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
  int waitPays;
  int waitReceives;
  int waitComments;

  Data({this.waitPays, this.waitReceives, this.waitComments});

  Data.fromJson(Map<String, dynamic> json) {
    waitPays = json['wait_pays'];
    waitReceives = json['wait_receives'];
    waitComments = json['wait_comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wait_pays'] = this.waitPays;
    data['wait_receives'] = this.waitReceives;
    data['wait_comments'] = this.waitComments;
    return data;
  }
}
