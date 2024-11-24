import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/car_model.dart';
import 'package:flutter/material.dart';

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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButton(),
                  CachedNetworkImage(
                    imageUrl: widget.car.image,
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
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
                  const SizedBox(height: 80), // Extra space at the bottom for button
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                child: CustomGradientButton(
                  onPressed: () {},
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  text: 'Buy Now',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
