class IndexCategory {
  int errcode;
  String errmsg;
  List<Data> data;

  IndexCategory({this.errcode, this.errmsg, this.data});

  IndexCategory.fromJson(Map<String, dynamic> json) {
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
  String imageCover;
  String title;
  int id;

  Data({this.imageCover, this.title, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    imageCover = json['image_cover'];
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_cover'] = this.imageCover;
    data['title'] = this.title;
    data['id'] = this.id;
    return data;
  }
}
