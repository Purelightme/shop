class ShoppingCartModel {
  int errcode;
  String errmsg;
  Data data;

  ShoppingCartModel({this.errcode, this.errmsg, this.data});

  ShoppingCartModel.fromJson(Map<String, dynamic> json) {
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
  int currentPage;
  List<Item> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Item>();
      json['data'].forEach((v) {
        data.add(new Item.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if(json['next_page_url'] != null){
      nextPageUrl = json['next_page_url'];
    }
    path = json['path'];
    perPage = json['per_page'];
    if(json['prev_page_url'] != null){
      prevPageUrl = json['prev_page_url'];
    }
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Item {
  int id;
  Product product;
  ProductSpecification productSpecification;
  int number;
  bool isChecked;
  bool isDoubleSpecification;
  List<DoubleSpecification> doubleSpecification;
  List<SingleSpecification> singleSpecification;

  Item(
      {this.id,
        this.product,
        this.productSpecification,
        this.doubleSpecification,
        this.singleSpecification,
        this.number,
        this.isDoubleSpecification,
        this.isChecked});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    productSpecification = json['product_specification'] != null
        ? new ProductSpecification.fromJson(json['product_specification'])
        : null;
    number = json['number'];
    isChecked = json['is_checked'];
    isDoubleSpecification = json['is_double_specification'];
    if (json['specification'] != null) {
      if (json['is_double_specification']){
        doubleSpecification = new List<DoubleSpecification>();
        json['specification'].forEach((v) {
          doubleSpecification.add(new DoubleSpecification.fromJson(v));
        });
      }else{
        singleSpecification = new List<SingleSpecification>();
        json['specification'].forEach((v) {
          singleSpecification.add(new SingleSpecification.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.productSpecification != null) {
      data['product_specification'] = this.productSpecification.toJson();
    }
    if (this.doubleSpecification != null) {
      data['double_specification'] =
          this.doubleSpecification.map((v) => v.toJson()).toList();
    }
    if (this.singleSpecification != null) {
      data['single_specification'] =
          this.singleSpecification.map((v) => v.toJson()).toList();
    }
    data['number'] = this.number;
    data['is_checked'] = this.isChecked;
    return data;
  }
}

class Product {
  int id;
  String imageCover;
  String longTitle;
  String expressFee;

  Product({this.id, this.imageCover, this.longTitle});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageCover = json['image_cover'];
    longTitle = json['long_title'];
    expressFee = json['express_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_cover'] = this.imageCover;
    data['long_title'] = this.longTitle;
    data['express_fee'] = this.expressFee;
    return data;
  }
}

class ProductSpecification {
  int id;
  String specificationString;
  String price;
  int firstIndex =0;
  int secondIndex =0;

  ProductSpecification({this.id, this.specificationString});

  ProductSpecification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specificationString = json['specification_string'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['specification_string'] = this.specificationString;
    data['price'] = this.price;
    return data;
  }
}

class DoubleSpecification {
  String title;
  int sort;
  String rootTitle;
  List<FirstChildren> children;

  DoubleSpecification({this.title, this.sort, this.rootTitle, this.children});

  DoubleSpecification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sort = json['sort'];
    rootTitle = json['root_title'];
    if (json['children'] != null) {
      children = new List<FirstChildren>();
      json['children'].forEach((v) {
        children.add(new FirstChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sort'] = this.sort;
    data['root_title'] = this.rootTitle;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FirstChildren {
  String title;
  int sort;
  String rootTitle;
  List<SecondChildren> children;

  FirstChildren({this.title, this.sort, this.rootTitle, this.children});

  FirstChildren.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sort = json['sort'];
    rootTitle = json['root_title'];
    if (json['children'] != null) {
      children = new List<SecondChildren>();
      json['children'].forEach((v) {
        children.add(new SecondChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sort'] = this.sort;
    data['root_title'] = this.rootTitle;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecondChildren {
  int id;
  int productId;
  String price;
  int stock;

  SecondChildren({this.id, this.productId, this.price, this.stock});

  SecondChildren.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['stock'] = this.stock;
    return data;
  }
}

class SingleSpecification {
  String title;
  int sort;
  String rootTitle;
  List<Children> children;

  SingleSpecification({this.title, this.sort, this.rootTitle, this.children});

  SingleSpecification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sort = json['sort'];
    rootTitle = json['root_title'];
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sort'] = this.sort;
    data['root_title'] = this.rootTitle;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int id;
  int productId;
  String price;
  int stock;

  Children({this.id, this.productId, this.price, this.stock});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['stock'] = this.stock;
    return data;
  }
}


