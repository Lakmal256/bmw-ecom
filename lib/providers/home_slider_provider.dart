import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/controllers.dart';
import '../utils/utils.dart';

class HomeSliderProvider extends ChangeNotifier {
  File _image = File("");
  ImagePicker picker = ImagePicker();
  List<String> _sliderImages = ["", "", "", "", "", ""];
  List<String> get sliderImages => _sliderImages;

  String generateRandomNumber() {
    Random random = Random();
    int randomNumber = random.nextInt(100) + 1;
    return 'homeSlider_$randomNumber';
  }

  Future<void> pickImage(context, index) async {
    locate<ProgressIndicatorController>().show();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    locate<ProgressIndicatorController>().hide();

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      _sliderImages[index] = _image.path;
      notifyListeners();

      locate<ProgressIndicatorController>().show();
      try {
        String imgUrl = await StorageController().uploadImage(_image, 'Uploads', generateRandomNumber());
        HomeSliderController().addSliderImage(index, imgUrl, context);
      } catch (e) {
        // Handle any errors during upload
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Upload Failed",
            subtitle: "Could not upload the image. Please try again.",
            color: Colors.red,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 3),
        );
      } finally {
        locate<ProgressIndicatorController>().hide();
      }
    } else {
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Image Not Picked",
          subtitle: "Please add an image.",
          color: Colors.red,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 3),
      );
    }
  }

  void updateSliderImageList(List<String> list) {
    _sliderImages = list;
    notifyListeners();
  }
}
