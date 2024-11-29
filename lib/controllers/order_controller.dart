import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import '../utils/utils.dart';

class OrderController {
  final CollectionReference order = FirebaseFirestore.instance.collection("Orders");

  Future<void> saveOrder(OrderModel oModel, BuildContext context) async {
    try {
      String docId = order.doc().id;
      oModel.orderId = docId;
      Map<String, dynamic> orderJson = oModel.toJson();

      await order.doc(docId).set(orderJson).then((value) {
        Logger().w("Order Saved");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomNavigator().goTo(context, const MyOrders());
        });
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<List<OrderModel>> fetchMyOrders(String uid) async {
    List<OrderModel> orders = [];
    QuerySnapshot snapshot = await order.where("user.uid", isEqualTo: uid).get();

    for (var order in snapshot.docs) {
      OrderModel myOrder = OrderModel.fromJson(order.data() as Map<String, dynamic>);

      orders.add(myOrder);
    }
    return orders;
  }
}
