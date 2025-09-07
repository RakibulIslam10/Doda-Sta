import 'package:doda_work/core/utils/basic_import.dart';
import 'package:get/get.dart';

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
