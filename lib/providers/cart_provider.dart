import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import 'providers.dart';

class CartProvider extends ChangeNotifier {
  // OrderController oController = OrderController();
  int _quantity = 1;
  int get quantity => _quantity;
  List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;
  double _total = 0;
  DateTime purchaseTime = DateTime.now();
  late String formattedDate;

  void increaseQuantity() {
    _quantity++; //_quantity = _quantity + 1;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity != 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void addToCart(CarModel car) {
    if (_cartItems.any((element) => element.car.id == car.id)) {
      _cartItems.removeWhere((element) => element.car.id == car.id);
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Product removed from Cart",
          subtitle: "Product removed from Cart successfully",
          color: Colors.orange,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 3),
      );
      notifyListeners();
    } else {
      _cartItems.add(CartModel(car: car, quantity: _quantity));
      clearQuantity();
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Product added to Cart",
          subtitle: "Product added to Cart successfully",
          color: Colors.green,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 3),
      );
      notifyListeners();
    }
  }

  void removeFromCart(CarModel car) {
    _cartItems.removeWhere((element) => element.car.id == car.id);
    notifyListeners();
  }

  void clearQuantity() {
    _quantity = 1;
    notifyListeners();
  }

  void clearCart() {
    _total = 0;
    _cartItems = [];
    notifyListeners();
  }

  void increaseCartItemQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  void decreaseCartItemQuantity(int index) {
    if (_cartItems[index].quantity != 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  double calculateTotal() {
    double total = 0;
    for (var item in _cartItems) {
      total += double.parse(item.car.price) * item.quantity;
    }
    _total = total;
    return total;
  }

  Future<void> saveOrderDetails(BuildContext context) async {
    UserModel user =
    Provider.of<UserProvider>(context, listen: false).userData!;
    formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(purchaseTime);

    OrderModel orderModel = OrderModel(
      totalAmount: _total,
      orderId: "",
      items: _cartItems,
      user: user,
      purchaseTime: formattedDate,
    );
    OrderController().saveOrder(orderModel, context);
  }
}
