import 'dart:convert';

Food shopModelFromJson(String str) => Food.fromJson(json.decode(str));

String shopModelToJson(Food data) => json.encode(data.toJson());

class Food {
  String? id;
  String? price;
  String? foodName;
  String? imgURL;

  Food( { this.id, this.price, this.foodName, this.imgURL});

  factory Food.fromJson(Map<String, dynamic> json) => Food( id: json["id"],
      price: json["price"], foodName: json["foodName"], imgURL: json["imgURL"]);

  Map<String, dynamic> toJson() =>
      {"id":id, "price": price, "foodName": foodName, "imgURL": imgURL};
}
