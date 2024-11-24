import 'package:e_commerce/models/models.dart';

class CartModel {
  int quantity;
  CarModel car;

  CartModel({required this.car, required this.quantity});

  factory CartModel.fromJson(Map<String, dynamic> json) {

    return CartModel(
      car: CarModel.fromJson(json["car"] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"quantity": quantity, "car": car.toJson()};
  }
}