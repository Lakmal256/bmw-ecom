import 'package:logger/logger.dart';

class CarModel {
  String description;
  String id;
  String image;
  String name;
  String price;
  String type;

  CarModel({
    required this.description,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.type,
  });

  factory CarModel.fromJson(Map<String, dynamic> value) {
    try {
      return CarModel(
          description: value["description"],
          id: value["id"],
          image: value["image"],
          name: value["name"],
          price: value["price"],
          type: value["type"]);
    } catch (e) {
      Logger().e(e);
      return CarModel(
          description: "", id: "", image: "", name: "", price: "", type: "");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "id": id,
      "image": image,
      "name": name,
      "price": price,
      "type": type,
    };
  }
}