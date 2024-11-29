import 'models.dart';

class OrderModel {
  List<CartModel> items;
  UserModel user;
  String orderId;
  double totalAmount;
  String purchaseTime;

  OrderModel({required this.totalAmount, required this.orderId, required this.items, required this.user, required this.purchaseTime});

  factory OrderModel.fromJson(Map<String, dynamic> value) {
    try {
      List<CartModel> items = (value['items'] as List<dynamic>).map((e) => CartModel.fromJson(e)).toList();

      return OrderModel(
        totalAmount: (value["totalAmount"] as num).toDouble(),
        orderId: value['orderId'],
        items: items,
        user: UserModel.fromMap(value["user"] as Map<String, dynamic>),
        purchaseTime: value['purchaseTime'],
      );
    } catch (e) {
      return OrderModel(
          totalAmount: 0, orderId: "", items: [], user: UserModel(email: "", displayName: "", uid: "", favourite: []),purchaseTime: '');
    }
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemMapList = (items.map((e) => e.toJson())).toList();

    return {"items": itemMapList, "user": user.toJson(), "orderId": orderId, "totalAmount": totalAmount,"purchaseTime":purchaseTime};
  }
}
