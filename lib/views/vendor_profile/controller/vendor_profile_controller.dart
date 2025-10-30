import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/api/services/api.dart';
import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../../aditional/model/service_category_model.dart';
import '../model/provider_update_profile_model.dart';

class VendorProfileController extends GetxController {
  // TODO: Logic
  // name
  final nameController = TextEditingController();
  final contactPersonController = TextEditingController();
  final coveredRadius = TextEditingController();
  final websiteController = TextEditingController();
  final nameFocus = FocusNode();

  final locationController = TextEditingController();
  final locationFocus = FocusNode();

  // email
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final isEmailValid = false.obs;

  // number
  final numberController = TextEditingController();
  final numberFocus = FocusNode();

  final _imagePicker = ImagePicker();
  final Rx<File?> selectedImg = Rx(null);

  Future<void> pickImg() async {
    final pickedImg = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      selectedImg.value = File(pickedImg.path);
    } else {
      CustomSnackBar.error('Image not selected');
    }
  }

  List<ServiceCategory> serviceCategoryList = [];
  RxList selectedServiceList = [].obs;

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

  @override
  void onInit() {
    super.onInit();
    getServiceCategory();
  }

  // vendor update profile
  RxBool isLoading = false.obs;

  final Rxn<LatLng> selectedLatLng = Rxn<LatLng>();
  final RxString selectedAddress = "".obs;

  late ProviderUpdateProfileModel providerUpdateProfileModel;

  Future<ProviderUpdateProfileModel> vendorUpdateProfile() async {
    final Map<String, File?> fileMap = {};
    if (selectedImg.value != null) {
      fileMap['profile_image'] = selectedImg.value;
    }

    return await ApiRequest.multiMultipartRequest(
      token: AppStorage.temporaryToken,

      endPoint: ApiEndPoints.providerUpdateProfile,
      reqType: "PATCH",
      isLoading: isLoading,
      body: {
        'companyName': nameController.text.trim(),
        'contactPerson': nameController.text.trim(),
        'website': websiteController.text.trim(),
        'coveredRadius': coveredRadius.text.trim(),
        "latitude": selectedLatLng.value?.latitude.toString() ?? "",
        "longitude": selectedLatLng.value?.longitude.toString() ?? "",
        "serviceCategories": selectedServiceList,
        "serviceLocation": selectedAddress.value,
      },
      files: fileMap,
      fromJson: ProviderUpdateProfileModel.fromJson,
      showSuccessSnackBar: true,
      onSuccess: (_) => Get.offAllNamed(Routes.navigationScreen),
    );
  }
}
