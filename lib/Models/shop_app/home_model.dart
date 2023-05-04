class HomeModel {
  bool status;
  HomeDataModel data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJsonn(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel.fromJsonn(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(element);
    });
    json['products'].forEach((element) {
      products.add(element);
    });
  }
}

class BannerModel {
  int id;
  String image;
  BannerModel.fromJsonn(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int id;
  dynamic price, old_price, discount;
  String image, name;
  bool in_favorites, in_cart;

  ProductModel.fromJsonn(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
