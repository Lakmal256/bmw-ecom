import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/components.dart';
import '../providers/providers.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  String formatAmount(String amount) {
    double numericAmount = double.tryParse(amount) ?? 0.0;
    NumberFormat formatter = NumberFormat('#,##0.00');
    return formatter.format(numericAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Provider.of<LauncherProvider>(context, listen: false).changeIndex(0);
        }),
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return value.cartItems.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.cartItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: CachedNetworkImage(
                                      imageUrl: value.cartItems[index].car.image,
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      fit: BoxFit.fitWidth,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          value.cartItems[index].car.name.length > 16
                                              ? "${value.cartItems[index].car.name.substring(0, 16)}.."
                                              : value.cartItems[index].car.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(fontWeight: FontWeight.bold,color: Colors.black),
                                        ),
                                        Text(
                                          "\$ ${formatAmount(value.cartItems[index].car.price)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(fontWeight: FontWeight.bold,color: Colors.black),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Total - \$ ${formatAmount((double.parse(value.cartItems[index].car.price) * value.cartItems[index].quantity).toString())}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(fontWeight: FontWeight.bold,color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: InkWell(
                                          onTap: () {
                                            value.removeFromCart(value.cartItems[index].car);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 6.0, bottom: 6.0),
                                        child: Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade500,
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  value.decreaseCartItemQuantity(index);
                                                },
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Colors.blue.shade900,
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                value.cartItems[index].quantity.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(fontWeight: FontWeight.bold),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  value.increaseCartItemQuantity(index);
                                                },
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Colors.blue.shade900,
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  value.cartItems.isNotEmpty
                                      ? "\$ ${formatAmount(value.calculateTotal().toString())}"
                                      : "\$ 0",
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            CustomGradientButton(
                                onPressed: () {
                                  Provider.of<PaymentProvider>(context, listen: false)
                                      .getPayment(value.calculateTotal().toInt().toString(), context);
                                },
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                text: 'Buy Now'),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    "Cart is Empty!",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                );
        },
      ),
    );
  }
}
