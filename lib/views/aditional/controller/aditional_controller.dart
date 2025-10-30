import 'dart:io';

import 'package:doda_work/core/api/services/api.dart';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/aditional/model/provider_register_model.dart';
import 'package:doda_work/views/aditional/model/service_category_model.dart';
import 'package:doda_work/views/auth/register/controller/register_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/routes.dart';

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

  RxList<File> photos = <File>[].obs;

  final ImagePicker _picker = ImagePicker();

  // pick new photo
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      photos.add(File(pickedFile.path));
    }
  }

  // ✅ Currently editing day
  RxString currentEditingDay = ''.obs;

  // ✅ Check if day is selected
  bool isDaySelected(String day) {
    return availabilityMap.containsKey(day);
  }

  void selectTap(int index) {
    final day = dayList[index];
    currentEditingDay.value = day;

    // ✅ Load existing time if available
    if (availabilityMap.containsKey(day)) {
      startedTime.value = availabilityMap[day]!["startTime"]!;
      endTime.value = availabilityMap[day]!["endTime"]!;
    } else {
      startedTime.value = '';
      endTime.value = '';
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

  var selectedValues = <String>[].obs;

  void toggleValue(String value) {
    if (selectedValues.contains(value)) {
      selectedValues.remove(value);
    } else {
      selectedValues.add(value);
    }
  }

  void clearAll() {
    selectedValues.clear();
  }

  @override
  void onInit() {
    super.onInit();
    getServiceCategory();
  }

  RxList selectedServiceList = [].obs;

  // get service category api
  RxBool isLoading = false.obs;

  List<ServiceCategory> serviceCategoryList = [];

  Future<ServiceCategoryModel> getServiceCategory() async {
    return ApiRequest.get(
      fromJson: ServiceCategoryModel.fromJson,
      endPoint: ApiEndPoints.serviceCategory,
      isLoading: isLoading,
      onSuccess: (result) {
        serviceCategoryList.addAll(result.category);
        print(serviceCategoryList.length);
      },
    );
  }

  // ✅ Store time for each day separately
  RxMap<String, Map<String, String>> availabilityMap =
      <String, Map<String, String>>{}.obs;

  // ✅ Save time for current editing day
  void saveTimeForCurrentDay() {
    if (currentEditingDay.isEmpty) return;
    if (startedTime.value.isEmpty || endTime.value.isEmpty) return;

    availabilityMap[currentEditingDay.value] = {
      "startTime": startedTime.value,
      "endTime": endTime.value,
    };
    availabilityMap.refresh();

    print(
      'Saved for ${currentEditingDay.value}: ${startedTime.value} - ${endTime.value}',
    );
  }

  // ✅ Remove day availability
  void removeDayAvailability(String day) {
    availabilityMap.remove(day);
    availabilityMap.refresh();

    if (currentEditingDay.value == day) {
      currentEditingDay.value = '';
      startedTime.value = '';
      endTime.value = '';
    }
  }

  // ✅ Get final availability data (without isAvailable)
  List<Map<String, dynamic>> getAvailabilityData() {
    return availabilityMap.entries.map((entry) {
      return {
        "day": entry.key,
        "startTime": entry.value["startTime"],
        "endTime": entry.value["endTime"],
      };
    }).toList();
  }

  // provider register process api

  final Rxn<LatLng> selectedLatLng = Rxn<LatLng>();
  final RxString selectedAddress = "".obs;
  RxBool providerRegIsLoading = false.obs;

  providerRegisterProcess() async {
    return await ApiRequest.multiMultipartRequest(
      fromJson: ProviderRegisterModel.fromJson,
      endPoint: ApiEndPoints.providerRegister,
      isLoading: providerRegIsLoading,
      files: {},
      token: AppStorage.temporaryToken,
      body: {
        "companyName": Get.find<RegisterController>().nameController.text,
        "website": linkController.text,
        "serviceCategories": selectedServiceList,
        "serviceLocation": selectedAddress.value,
        "contactPerson": contactPersonController.text,
        "coveredRadius": 100,
        "workingHours": getAvailabilityData(),
        "latitude": selectedLatLng.value?.latitude.toString() ?? "",
        "longitude": selectedLatLng.value?.longitude.toString() ?? "",
      },
      reqType: 'POST',
      filesList: {'attachments': photos},
      onSuccess: (result) => Get.offAllNamed(Routes.navigationScreen),
    );
  }
}