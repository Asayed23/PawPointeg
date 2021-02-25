import 'package:meta/meta.dart';

class Order {
  Order({
    this.id,
    this.totalprice,
    this.orderStatus,
    this.orderNumber,
    this.paymentMethod,
    this.shippingaddress,
    this.products,
    this.order_date,
    this.payid,
  });

  int id;
  dynamic totalprice;
  String orderStatus;
  String orderNumber;
  String paymentMethod;
  int shippingaddress;
  List<dynamic> products;
  String order_date;
  String payid;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        totalprice: json["totalprice"],
        orderStatus: json["order_status"],
        orderNumber: json["order_number"],
        paymentMethod: json["payment_method"],
        shippingaddress: json["shippingaddress"],
        products: json['products'],
        order_date: json['order_date'],
        payid: json['payid'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalprice": totalprice,
        "order_status": orderStatus,
        "order_number": orderNumber,
        "payment_method": paymentMethod,
        "shippingaddress": shippingaddress,
        'products': products,
        'order_date': order_date,
        'payid': payid
      };
}
