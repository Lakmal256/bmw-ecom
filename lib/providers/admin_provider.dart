import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controllers/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/utils.dart';

class AdminProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File _image = File('');
  ImagePicker picker = ImagePicker();
  CollectionReference product = FirebaseFirestore.instance.collection('Products');

  TextEditingController get nameController => _nameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get typeController => _typeController;
  TextEditingController get priceController => _priceController;
  File get image => _image;

  String generateRandomNumber(String name) {
    Random random = Random();
    int randomNumber = random.nextInt(100) + 1;
    return '${name}_$randomNumber';
  }

  Future<void> addProduct() async {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _typeController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _image.path == '') {
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "All Field Required",
          subtitle: "Please fill all filed include with a image",
          color: Colors.red,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 5),
      );
    } else {
      locate<ProgressIndicatorController>().show();
      String imageUrl =
          await StorageController().uploadImage(_image, 'Uploads', generateRandomNumber(_nameController.text));
      if (imageUrl != '') {
        DocumentReference productDoc = await product.add({
          'name': _nameController.text,
          'description': _descriptionController.text,
          'type': _typeController.text,
          'price': _priceController.text,
          'image': imageUrl
        }).then((value) {
          product.doc(value.id).update({'id': value.id});

          locate<ProgressIndicatorController>().hide();
          locate<PopupController>().addItemFor(
            DismissiblePopup(
              title: "Product Added",
              subtitle: "Product added successfully",
              color: Colors.green,
              onDismiss: (self) => locate<PopupController>().removeItem(self),
            ),
            const Duration(seconds: 5),
          );
          return value;
        });
        clearAddProductForm();
      }
    }
  }

  Future<void> pickImage() async {
    locate<ProgressIndicatorController>().show();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    locate<ProgressIndicatorController>().hide();
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
    } else {
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Something Went Wrong",
          subtitle: "Image not added",
          color: Colors.red,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 5),
      );
    }
  }

  void clearAddProductForm() {
    _nameController.clear();
    _descriptionController.clear();
    _typeController.clear();
    _priceController.clear();
    _image = File('');
    notifyListeners();
  }

  void removeImage() {
    _image = File('');
    notifyListeners();
  }
}
