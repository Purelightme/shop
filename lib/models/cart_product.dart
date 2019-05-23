class CartProduct {
  String imageCover;
  String title;
  String specification;
  int num;
  String price;

  CartProduct(
      {this.imageCover, this.title, this.specification, this.num, this.price});

  CartProduct.fromJson(Map<String, dynamic> json) {
    imageCover = json['image_cover'];
    title = json['title'];
    specification = json['specification'];
    num = json['num'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_cover'] = this.imageCover;
    data['title'] = this.title;
    data['specification'] = this.specification;
    data['num'] = this.num;
    data['price'] = this.price;
    return data;
  }
}