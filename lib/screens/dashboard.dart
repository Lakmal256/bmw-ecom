import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/screens/product_details_screen.dart';
import 'package:e_commerce/screens/screens.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> offers = ['assets/bmw_xm.jpg', 'assets/bmw_xm.jpg', 'assets/bmw_xm.jpg'];

  List<CarModel> cars = [
    CarModel(
        description: 'description', id: 100, image: 'assets/bmw_xm.jpg', name: 'BMW XM', price: 99999, type: 'Hyper'),
    CarModel(
        description: 'description', id: 100, image: 'assets/bmw_xm.jpg', name: 'BMW XM', price: 99999, type: 'Hyper'),
    CarModel(
        description: 'description', id: 100, image: 'assets/bmw_xm.jpg', name: 'BMW XM', price: 99999, type: 'Hyper'),
    CarModel(
        description: 'description', id: 100, image: 'assets/bmw_xm.jpg', name: 'BMW XM', price: 99999, type: 'Hyper'),
    CarModel(
        description: 'description', id: 100, image: 'assets/bmw_xm.jpg', name: 'BMW XM', price: 99999, type: 'Hyper'),
    CarModel(
        description: 'description', id: 100, image: 'assets/bmw_xm.jpg', name: 'BMW XM', price: 99999, type: 'Hyper'),
    CarModel(
        description: 'description', id: 100, image: 'assets/bmw_xm.jpg', name: 'BMW XM', price: 99999, type: 'Hyper'),
    CarModel(
        description: 'description', id: 100, image: 'assets/bmw_xm.jpg', name: 'BMW XM', price: 99999, type: 'Hyper'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search_outlined),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0), // Add space below Row
                    Text(
                      'Hello Kamal',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Let's Start !",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CarouselSlider(
                options: CarouselOptions(height: 150.0, autoPlay: true),
                items: offers.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyCart(),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              i.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(car: cars[index]),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey.shade600,
                                    )),
                                Image.asset(cars[index].image),
                                const SizedBox(height: 10),
                                Text(
                                  cars[index].name,
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '\$ ${cars[index].price}',
                                  style: Theme.of(context).textTheme.labelLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
