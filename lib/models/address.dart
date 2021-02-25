class ShippingAddress {
  ShippingAddress({
    this.id,
    this.city,
    this.area,
    this.street,
    this.building,
    this.floor,
    this.apartment,
    this.landmark,
    this.shipping_note,
    this.address_name,
    this.address_type,
    this.selected,
    this.address_id,
  });

  int id;
  String city;
  String area;
  String street;
  String building;
  String floor;
  String apartment;
  String landmark;
  String shipping_note;
  String addresstype;
  String address_name;
  String address_type;
  bool selected;
  int address_id;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
        city: json["city"],
        area: json["area"],
        street: json["street"],
        building: json["building"],
        floor: json["floor"],
        apartment: json["apartment"],
        landmark: json["landmark"],
        shipping_note: json["shipping_note"],
        address_name: json["address_name"],
        address_type: json["address_type"],
        selected: json["selected"],
        address_id: json['address_id'],
      );
}
