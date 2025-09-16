import 'dart:io';

import 'package:doda_work/core/utils/basic_import.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AditionalController extends GetxController {
  List<String> dayList = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  RxList<File> photos = <File>[].obs;  // all picked photos

  final ImagePicker _picker = ImagePicker();

// pick new photo
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photos.add(File(pickedFile.path));
    }
  }
  RxList<String> selectedDay = <String>[].obs;

  void selectTap(int index) {
    if (selectedDay.contains(dayList[index])) {
      selectedDay.remove(dayList[index]);
    } else {
      selectedDay.add(dayList[index]);
    }
  }

  final RxString startDate = ''.obs;
  final RxString endDate = ''.obs;

  final RxString endTime = ''.obs;
  final RxString startedTime = ''.obs;

  final RxString selectedCategory = ''.obs;
  final RxString selectedSubCategory = ''.obs;

  final serviceLocationController = TextEditingController();
  final contactPersonController = TextEditingController();
  final companyNameController = TextEditingController();
  final linkController = TextEditingController();





}
