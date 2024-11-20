import 'package:e_commerce/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Provider.of<AdminProvider>(context, listen: false).clearAddProductForm();
          Navigator.of(context).pop();
        }),
        title: Text(
          'Add Products',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<AdminProvider>(builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                      child: TextField(
                        controller: value.nameController,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        style: GoogleFonts.lato(color: const Color(0xFF000000)),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Item Name",
                          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                          prefixIcon: const Icon(
                            Icons.directions_car,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                      child: TextField(
                        controller: value.descriptionController,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        style: GoogleFonts.lato(color: const Color(0xFF000000)),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Item Description",
                          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                          prefixIcon: const Icon(
                            Icons.car_rental_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                      child: TextField(
                        controller: value.typeController,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        style: GoogleFonts.lato(color: const Color(0xFF000000)),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Item Type",
                          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                          prefixIcon: const Icon(
                            Icons.car_repair_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                      child: TextField(
                        controller: value.priceController,
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        style: GoogleFonts.lato(color: const Color(0xFF000000)),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Item Price",
                          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                          prefixIcon: const Icon(
                            Icons.attach_money_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                value.image.path.isEmpty
                    ? Container(
                        height: 80,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            value.pickImage();
                          },
                        ),
                      )
                    : Stack(
                        children: [
                          // Display the uploaded image
                          Container(
                            height: 160,
                            width: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(value.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                value.removeImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                CustomGradientButton(
                    onPressed: () {
                      value.addProduct();
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    text: 'Add Product'),
              ],
            );
          }),
        ),
      ),
    );
  }
}
