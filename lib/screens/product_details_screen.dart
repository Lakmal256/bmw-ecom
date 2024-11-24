import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/car_model.dart';
import 'package:e_commerce/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';

class ProductDetails extends StatefulWidget {
  final CarModel car;
  const ProductDetails({super.key, required this.car});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CartProvider>(builder: (context, value, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButton(),
                    CachedNetworkImage(
                      imageUrl: widget.car.image,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    ),
                    Text(
                      widget.car.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$ ${widget.car.price}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.car.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Quantity",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Container(
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
                                  value.decreaseQuantity();
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
                                value.quantity.toString(),
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  value.increaseQuantity();
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                  child: CustomGradientButton(
                    onPressed: () {
                      value.addToCart(widget.car);
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    text: value.cartItems.any((element) => element.car.id == widget.car.id)
                        ? 'Remove from Cart'
                        : 'Add to Cart',
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
