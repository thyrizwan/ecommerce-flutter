class ShippingAddressModel {
  String? fullName;
  String? address;
  String? city;
  String? postalCode;
  String? phone;

  ShippingAddressModel({
    this.fullName,
    this.address,
    this.city,
    this.postalCode,
    this.phone,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ShippingAddressModel();
    return ShippingAddressModel(
      fullName: json["full_name"],
      address: json["address"],
      city: json["city"],
      postalCode: json["postal_code"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "address": address,
      "city": city,
      "postal_code": postalCode,
      "phone": phone,
    };
  }
}
