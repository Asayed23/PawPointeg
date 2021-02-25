class Cart {
  Cart({
    this.id,
    this.quantity,
    this.price,
    this.cartIdId,
    this.productidId,
  });

  int id;
  int quantity;
  double price;
  int cartIdId;
  int productidId;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        quantity: json["quantity"],
        price: json["price"],
        cartIdId: json["CartId_id"],
        productidId: json["productid_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "price": price,
        "CartId_id": cartIdId,
        "productid_id": productidId,
      };
}
