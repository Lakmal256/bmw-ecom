import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/utils.dart';

class StorageController {
  Future<String> uploadImage(File file, String bucketName, String path) async {
    try {
      final supabase = Supabase.instance.client;
      final bytes = await file.readAsBytes();
      final response = await supabase.storage.from(bucketName).uploadBinary(
            path,
            bytes,
          );
      final publicUrl = supabase.storage.from(bucketName).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      locate<ProgressIndicatorController>().hide();
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Image Upload Failed",
          subtitle: "Please try again",
          color: Colors.red,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 5),
      );
      return '';
    }
  }
}
