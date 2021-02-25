import 'package:meta/meta.dart';

class InLoading {
  InLoading({
    this.address = true,
    this.cart = true,
    this.currentorder = true,
    this.order = true,
    this.user = true,
    this.dogproduct = true,
    this.allproduct = true,
    this.catproduct = true,
    this.servproduct = true,
    this.bestproduct = true,
    this.favproduct = true,
    this.selected = false,
  });

  bool address;
  bool cart;
  bool currentorder;
  bool order;
  bool user;
  bool dogproduct;
  bool selected;
  bool allproduct;
  bool catproduct;
  bool servproduct;
  bool bestproduct;
  bool favproduct;

  factory InLoading.fromJson(Map<String, dynamic> json) => InLoading(
        address: json["address"],
        cart: json["cart"],
        currentorder: json["currentorder"],
        order: json["order"],
        user: json["user"],
        dogproduct: json["dogproduct"],
        selected: json['selected'],
        allproduct: json['allproduct'],
        catproduct: json['catproduct'],
        servproduct: json['servproduct'],
        bestproduct: json['bestproduct'],
        favproduct: json['favproduct'],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "cart": cart,
        "currentorder": currentorder,
        "order": order,
        "user": user,
        "dogproduct": dogproduct,
        'selected': selected,
        'allproduct': allproduct,
        'catproduct': catproduct,
        'servproduct': servproduct,
        'bestproduct': bestproduct,
        'favproduct': favproduct,
      };
}
