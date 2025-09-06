import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CertificateController extends GetxController {
  // TODO: Logic
  RxList<File> photos = <File>[].obs;  // all picked photos

  final ImagePicker _picker = ImagePicker();

// pick new photo
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photos.add(File(pickedFile.path));
    }
  }
}
