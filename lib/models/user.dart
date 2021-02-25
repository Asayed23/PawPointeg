import 'package:meta/meta.dart';

class User {
  int id;
  String username;
  String email;
  String full_name;
  int phone_number;
  String jwt;
  int cartId;
  int customerId;
  int favourite_id;

  User(
      {@required this.id,
      @required this.username,
      @required this.email,
      @required this.jwt,
      @required this.cartId,
      @required this.favourite_id,
      @required this.phone_number,
      @required this.full_name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      jwt: json['jwt'],
      cartId: json['cart_id'],
      favourite_id: json['favourite_id'],
      phone_number: json['phone_number'],
      full_name: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "jwt": jwt,
        "cart_id": cartId,
        "favourite_id": favourite_id,
        "phone_number": phone_number,
        "full_name": full_name,
      };
}
