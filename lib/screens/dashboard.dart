import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String formatAmount(String amount) {
    double numericAmount = double.tryParse(amount) ?? 0.0;
    NumberFormat formatter = NumberFormat('#,##0.00');
    return formatter.format(numericAmount);
  }

  @override
  Widget build(BuildContext context) {
    // Assuming sliderImages comes from the HomeSliderProvider
    List<String> sliderImages = Provider.of<HomeSliderProvider>(context).sliderImages;

    // Filtered list containing only valid URLs
    List<String> filteredImages = sliderImages.where((image) => image.contains('https://')).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0), // Add space below Row
                    Text(
                      Provider.of<UserProvider>(context, listen: false).userData?.displayName != null
                          ? 'Hello! ${Provider.of<UserProvider>(context, listen: false).userData!.displayName}'
                          : 'Hello!',
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
                items: filteredImages.isNotEmpty
                    ? filteredImages.map((image) {
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
                                  child: CachedNetworkImage(
                                    imageUrl: image,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    fit: BoxFit.fitWidth,
                                    height: 100,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList()
                    : [
                        // If no valid URLs, use a fallback image inside the carousel
                        Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/BMW-Logo.png',
                                  fit: BoxFit.fitWidth,
                                  height: 100,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: FutureBuilder(
                  future: Provider.of<AdminProvider>(context, listen: false).fetchProducts().then(
                    (value) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Provider.of<UserProvider>(context, listen: false).filterFavouriteItems(value);
                      });
                      return value;
                    },
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.data?.isEmpty == true) {
                      return Center(
                        child: Text(
                          'No available Cars here!',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    } else {
                      List<CarModel> cars = snapshot.data!;
                      return GridView.builder(
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
                                child: Consumer<UserProvider>(
                                  builder: (context, value, child) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              if (value.favItems.contains(cars[index].id)) {
                                                value.removeFromFavourite(context, cars[index]);
                                              } else {
                                                value.addToFavourite(context, cars[index]);
                                              }
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: value.favItems.contains(cars[index].id)
                                                  ? Colors.red.shade600
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        CachedNetworkImage(
                                          imageUrl: cars[index].image,
                                          placeholder: (context, url) =>
                                              const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 80,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          cars[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '\$ ${formatAmount(cars[index].price)} upwards',
                                          style: Theme.of(context).textTheme.labelLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
