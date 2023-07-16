
import 'dart:convert';

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  String? id;
  String? shopName;
  String? email;
  String? country;

  ShopModel({
    this.id,
    this.shopName,
    this.email,
    this.country,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["id"],
        shopName: json["shopName"],
        email: json["email"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shopName": shopName,
        "email": email,
        "country": country,
      };
}
