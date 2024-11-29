import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class HomeSliderController {
  CollectionReference sliderImage = FirebaseFirestore.instance.collection("Home Slider Images");
  Future<void> addSliderImage(index, imgUrl, context) async {
    try {
      await sliderImage.doc((index + 1).toString()).set({"image": imgUrl}).then((value) {
        locate<ProgressIndicatorController>().hide();
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Home Slider Image Updated",
            subtitle: "Home Slider Image Update Successfully!",
            color: Colors.green,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 3),
        );
      });
    } catch (e) {
      locate<ProgressIndicatorController>().hide();
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Something Went Wrong",
          subtitle: e.toString(),
          color: Colors.red,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 3),
      );
    }
  }

  Future<List<String>> getSliderImages() async {
    List<String> sliderImages = ["", "", "", "", "", ""];
    QuerySnapshot snapshot = await sliderImage.get();

    for (var element in snapshot.docs) {
      // Parse the document ID to an integer
      int docId = int.tryParse(element.id) ?? -1;

      // Map the doc ID (1-6) to the list index (0-5)
      if (docId >= 1 && docId <= 6) {
        int index = docId - 1;
        sliderImages[index] = (element.data() as Map<String, dynamic>)['image'];
      }
    }

    return sliderImages;
  }
}
