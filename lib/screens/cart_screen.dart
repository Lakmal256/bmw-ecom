import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../providers/providers.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
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
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Provider.of<LauncherProvider>(context, listen: false).changeIndex(0);
          },
        ),
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              cars[index].image,
                              width: 120,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cars[index].name,
                                    style:
                                        Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$ ${cars[index].price}',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey, width: 2),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove, size: 15),
                                  Text('1'),
                                  Icon(Icons.add, size: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$ 40000',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomGradientButton(
                  onPressed: () {}, width: MediaQuery.of(context).size.width, height: 45, text: 'Buy Now'),
            ],
          ),
        ),
      ),
    );
  }
}
