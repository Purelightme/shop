class CategoryModel {
  int errcode;
  String errmsg;
  List<Data> data;

  CategoryModel({this.errcode, this.errmsg, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
  String title;
  List<Children> children;

  Data({this.id, this.title, this.children});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int id;
  String title;
  List<LastChildren> lastChildren;

  Children({this.id, this.title, this.lastChildren});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['last_children'] != null) {
      lastChildren = new List<LastChildren>();
      json['last_children'].forEach((v) {
        lastChildren.add(new LastChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.lastChildren != null) {
      data['last_children'] = this.lastChildren.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastChildren {
  String imageCover;
  String title;
  int id;

  LastChildren({this.imageCover, this.title, this.id});

  LastChildren.fromJson(Map<String, dynamic> json) {
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
