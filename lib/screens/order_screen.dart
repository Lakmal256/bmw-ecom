import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {

    String formatAmount(String amount) {
      double numericAmount = double.tryParse(amount) ?? 0.0;
      NumberFormat formatter = NumberFormat('#,##0.00');
      return formatter.format(numericAmount);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).getMyOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No orders found"));
          }
          List<OrderModel> orders = snapshot.data!;

          // Sort the orders by purchaseTime in descending order
          orders.sort((a, b) {
            DateTime dateA = DateFormat('dd-MM-yyyy HH:mm').parse(a.purchaseTime);
            DateTime dateB = DateFormat('dd-MM-yyyy HH:mm').parse(b.purchaseTime);
            return dateB.compareTo(dateA); // Newest first
          });

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  height: 270,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Id : ${orders[index].orderId}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Items : ${orders[index].items.length}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Total : \$${formatAmount(orders[index].totalAmount.toString())}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Purchase Date/Time : ${orders[index].purchaseTime}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              orders[index].items.length,
                                  (i) => SizedBox(
                                width: 110,
                                height: 170,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: CachedNetworkImage(
                                          imageUrl: orders[index].items[i].car.image,
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                          fit: BoxFit.fitWidth,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      orders[index].items[i].car.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Quantity - ${orders[index].items[i].quantity}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\$ ${formatAmount(orders[index].items[i].car.price)}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}