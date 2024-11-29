import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class UpdateSlider extends StatefulWidget {
  const UpdateSlider({super.key});

  @override
  State<UpdateSlider> createState() => _UpdateSliderState();
}

class _UpdateSliderState extends State<UpdateSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Slider"),
      ),
      body: Consumer<HomeSliderProvider>(builder: (context, value, child) {
        return Center(
            child: Wrap(
          children: List.generate(
              6,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        value.pickImage(context, index);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade400,
                        ),
                        child: Center(
                          child: value.sliderImages[index] != ""
                              ? value.sliderImages[index].contains("https://")
                                  ? CachedNetworkImage(
                                      imageUrl: value.sliderImages[index],
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 180,
                                    )
                                  : Image.file(
                                      File(value.sliderImages[index]),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 180,
                                    )
                              : const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ),
                  )),
        ));
      }),
    );
  }
}
