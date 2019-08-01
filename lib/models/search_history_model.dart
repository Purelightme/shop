class SearchHistoryModel {
  int errcode;
  String errmsg;
  List<String> data;

  SearchHistoryModel({this.errcode, this.errmsg, this.data});

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    errmsg = json['errmsg'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errcode'] = this.errcode;
    data['errmsg'] = this.errmsg;
    data['data'] = this.data;
    return data;
  }
}
