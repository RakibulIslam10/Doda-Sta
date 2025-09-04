import 'dart:io';

import 'package:doda_work/core/utils/basic_import.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class RequestController extends GetxController {
  // TODO: Logic
final serviceAddressController = TextEditingController();
final requestController = TextEditingController();
  final RxString startDate =  ''.obs;
  final RxString endDate =  ''.obs;

  final RxString endTime =  ''.obs;
  final RxString startedTime =  ''.obs;

  final RxString selectedCategory =  ''.obs;
  final RxString selectedSubCategory =  ''.obs;

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
