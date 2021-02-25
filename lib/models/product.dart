class Product {
  int id;
  int quantity;
  double itemPrice;
  int cartIdId;
  int productidId;
  String name;
  dynamic brand;
  dynamic productId;
  double weight;
  dynamic madeIn;
  String description;
  String moreDesc;
  dynamic foodType;
  dynamic lifeStage;
  dynamic flavor;
  String ingredients;
  String directions;
  dynamic size;
  dynamic pet;
  dynamic category;
  dynamic subCategory;
  dynamic service;
  dynamic tag;
  int stockQuantity;
  double price;
  double totalPrice;
  String picture;
  dynamic discount;
  bool bestSelling;
  bool limitedOffer;
  dynamic relatedProducts;
  bool hasmore;

  Product({
    this.id,
    this.quantity,
    this.itemPrice,
    this.cartIdId,
    this.productidId,
    this.name,
    this.brand,
    this.productId,
    this.weight,
    this.madeIn,
    this.description,
    this.moreDesc,
    this.foodType,
    this.lifeStage,
    this.flavor,
    this.ingredients,
    this.directions,
    this.size,
    this.pet,
    this.category,
    this.subCategory,
    this.service,
    this.tag,
    this.stockQuantity,
    this.price,
    this.totalPrice,
    this.picture,
    this.discount,
    this.bestSelling,
    this.limitedOffer,
    this.relatedProducts,
    this.hasmore,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      quantity: json["quantity"],
      itemPrice: json["item_price"],
      cartIdId: json["CartId_id"],
      productidId: json["productid_id"],
      name: json["name"],
      brand: json["brand"],
      productId: json["productID"],
      weight: json["weight"].toDouble(),
      madeIn: json["made_in"],
      description: json["desc"],
      moreDesc: json["moreDesc"],
      foodType: json["foodType"],
      lifeStage: json["lifeStage"],
      flavor: json["flavor"],
      ingredients: json["ingredients"],
      directions: json["directions"],
      size: json["size"],
      pet: json["pet"],
      category: json["category"],
      subCategory: json["subCategory"],
      service: json["service"],
      tag: json["tag"],
      stockQuantity: json["stock_quantity"],
      price: json["price"],
      totalPrice: json["totalPrice"],
      picture: json["picture"],
      discount: json["discount"],
      bestSelling: json["best_selling"],
      limitedOffer: json["limited_offer"],
      relatedProducts: json["related_products"],
      hasmore: json["hasmore"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "desc": description,
        "picture": picture,
        "service": service,
        "pet": pet,
        "category": category,
        "subCategory": subCategory,
        "stock_quantity": stockQuantity,
        "weight": weight,
        "brand": brand,
        "productID": productId,
        "made_in": madeIn,
        "moreDesc": moreDesc,
        "foodType": foodType,
        "lifeStage": lifeStage,
        "flavor": flavor,
        "ingredients": ingredients,
        "directions": directions,
        "size": size,
        "tag": tag,
        "discount": discount,
        "best_selling": bestSelling,
        "limited_offer": limitedOffer,
        "related_products": relatedProducts,
      };
}
