import 'dart:developer';
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
  // ------------------------ DAY LIST ------------------------
  List<String> dayList = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  // ------------------------ Photos ------------------------
  RxList<File> photos = <File>[].obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      photos.add(File(pickedFile.path));
    }
  }

  // ------------------------ Working Hours ------------------------
  RxString currentEditingDay = ''.obs;
  final RxString startedTime = ''.obs;
  final RxString endTime = ''.obs;

  // Map: { "Sunday": { "startTime": "10 AM", "endTime": "6 PM" } }
  RxMap<String, Map<String, String>> availabilityMap =
      <String, Map<String, String>>{}.obs;

  bool isDaySelected(String day) => availabilityMap.containsKey(day);

  void selectTap(int index) {
    final day = dayList[index];
    currentEditingDay.value = day;

    if (availabilityMap.containsKey(day)) {
      startedTime.value = availabilityMap[day]!["startTime"]!;
      endTime.value = availabilityMap[day]!["endTime"]!;
    } else {
      startedTime.value = '';
      endTime.value = '';
    }
  }

  void saveTimeForCurrentDay() {
    if (currentEditingDay.isEmpty) return;
    if (startedTime.value.isEmpty || endTime.value.isEmpty) return;

    availabilityMap[currentEditingDay.value] = {
      "startTime": startedTime.value,
      "endTime": endTime.value,
    };

    availabilityMap.refresh();
  }

  void removeDayAvailability(String day) {
    availabilityMap.remove(day);
    availabilityMap.refresh();

    if (currentEditingDay.value == day) {
      currentEditingDay.value = '';
      startedTime.value = '';
      endTime.value = '';
    }
  }

  List<Map<String, dynamic>> getAvailabilityData() {
    return availabilityMap.entries.map((entry) {
      return {
        "day": entry.key,
        "startTime": entry.value["startTime"],
        "endTime": entry.value["endTime"],
      };
    }).toList();
  }

  // ------------------------ CATEGORY ------------------------
  RxList selectedServiceList = [].obs;

  RxBool isLoading = false.obs;
  List<ServiceCategory> serviceCategoryList = [];

  @override
  void onInit() {
    super.onInit();
    getServiceCategory();
  }

  Future<ServiceCategoryModel> getServiceCategory() async {
    return ApiRequest.get(
      fromJson: ServiceCategoryModel.fromJson,
      endPoint: ApiEndPoints.serviceCategory,
      isLoading: isLoading,
      onSuccess: (result) {
        serviceCategoryList.addAll(result.category);
      },
    );
  }

  // ------------------------ Form Inputs ------------------------
  final serviceLocationController = TextEditingController();
  final contactPersonController = TextEditingController();
  final companyNameController = TextEditingController();
  final linkController = TextEditingController();

  // ------------------------ Multi-value selection ------------------------
  var selectedValues = <String>[].obs;

  void toggleValue(String value) {
    selectedValues.contains(value)
        ? selectedValues.remove(value)
        : selectedValues.add(value);
  }

  void clearAll() => selectedValues.clear();

  // ------------------------ MAP Location ------------------------
  final Rxn<LatLng> selectedLatLng = Rxn<LatLng>();
  final RxString selectedAddress = "".obs;

  // ------------------------ Provider Register API ------------------------
  RxBool providerRegIsLoading = false.obs;

  providerRegisterProcess() async {
    // ✅ Check if token exists from user registration
    final userToken =  AppStorage.token;

    log('🔐 Using Token: ${userToken.isEmpty ? "NO TOKEN" : "TOKEN EXISTS"}');

    return await ApiRequest.multiMultipartRequest(
      fromJson: ProviderRegisterModel.fromJson,
      endPoint: ApiEndPoints.providerRegister,
      isLoading: providerRegIsLoading,
      files: {},
      body: {
        "companyName": Get.find<RegisterController>().nameController.text,
        "website": linkController.text,
        "serviceCategories": selectedServiceList,
        "serviceLocation": selectedAddress.value,
        "contactPerson": contactPersonController.text,
        "coveredRadius": 100,
        //todo
        "workingHours": getAvailabilityData(),
        "latitude": selectedLatLng.value?.latitude.toString() ?? "",
        "longitude": selectedLatLng.value?.longitude.toString() ?? "",
      },
      filesList: {
        "attachments": photos,
      },
      reqType: 'POST',
      token: userToken, // ✅ Pass the user token explicitly
      onSuccess: (result) {
        Get.defaultDialog(
          title: "Application Submitted",
          titleStyle: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
          middleText: "Your application is under review, and we will inform you when complete.",
          middleTextStyle: const TextStyle(fontSize: 14),
          barrierDismissible: false,
          confirm: ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.loginScreen),
            child: const Text("OK"),
          ),
        );
      },
    );
  }
}
