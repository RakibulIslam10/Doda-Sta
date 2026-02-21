import 'dart:io';

import 'package:doda_work/views/profile/controller/profile_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/api/services/api.dart';
import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../../aditional/model/service_category_model.dart';
import '../model/provider_update_profile_model.dart';

class VendorProfileController extends GetxController {
  final nameController = TextEditingController();
  final contactPersonController = TextEditingController();
  final coveredRadius = TextEditingController();
  final websiteController = TextEditingController();
  final nameFocus = FocusNode();
  final locationController = TextEditingController();
  final locationFocus = FocusNode();
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final numberController = TextEditingController();
  final numberFocus = FocusNode();

  // Observables
  final isEmailValid = false.obs;
  final Rx<File?> selectedImg = Rx(null);
  final RxBool isLoading = false.obs;
  final Rxn<LatLng> selectedLatLng = Rxn<LatLng>();
  final RxString selectedAddress = "".obs;
  final RxList selectedServiceList = [].obs;






  @override
  void onInit() {

    super.onInit();

    getServiceCategory();

    // Debug: Print current storage state
    print('🔐 Storage State:');
    print('   Token: ${AppStorage.token.isNotEmpty ? "Present" : "Empty"}');
    print('   Is Vendor: ${AppStorage.isVendor}');
    print('   Is Logged In: ${AppStorage.isLoggedIn}');


    nameController.text = Get.find<ProfileController>().providerProfileModel?.data.companyName ?? "";
    contactPersonController.text = Get.find<ProfileController>().providerProfileModel?.data.contactPerson ?? "";
    coveredRadius.text = Get.find<ProfileController>().providerProfileModel?.data.coveredRadius.toString() ?? "";
    websiteController.text = Get.find<ProfileController>().providerProfileModel?.data.website.toString() ?? "";
    selectedAddress.value = Get.find<ProfileController>().providerProfileModel?.data.serviceLocation ?? "";

    final lat = Get.find<ProfileController>().providerProfileModel?.data.latitude;
    final lng = Get.find<ProfileController>().providerProfileModel?.data.longitude;

    if (lat != null && lng != null) {
      selectedLatLng.value = LatLng(lat, lng);
    }

    emailController.addListener(() {
      final email = emailController.text.trim();
      isEmailValid.value = GetUtils.isEmail(email);
    });
  }



  // Other variables
  final _imagePicker = ImagePicker();
  bool isPickingImage = false;
  List<ServiceCategory> serviceCategoryList = [];
  ProviderUpdateProfileModel? providerUpdateProfileModel;

  Future<void> pickImg() async {
    if (isPickingImage) return;

    try {
      isPickingImage = true;
      final pickedImg = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedImg != null) {
        selectedImg.value = File(pickedImg.path);
        print('✅ Image selected: ${pickedImg.path}');
      } else {
        print('❌ No image selected');
      }
    } catch (e) {
      print('❌ Error picking image: $e');
      _showSnackBar('Failed to pick image', isError: true);
    } finally {
      isPickingImage = false;
    }
  }

  Future<ServiceCategoryModel> getServiceCategory() async {
    return ApiRequest.get(
      fromJson: ServiceCategoryModel.fromJson,
      endPoint: ApiEndPoints.serviceCategory,
      isLoading: isLoading,
      onSuccess: (result) {
        serviceCategoryList.addAll(result.category);
        print('✅ Loaded ${serviceCategoryList.length} service categories');
      },
    );
  }

  Future<void> vendorUpdateProfile() async {
    try {
      final token = _getAuthToken();
      if (token == null) return;

      if (!_isUserVendor()) {
        _showSnackBar('Vendor access required', isError: true);
        Get.offAllNamed(Routes.homeScreen);
        return;
      }

      // Prepare request data
      final Map<String, dynamic> body = _prepareRequestBody();
      final Map<String, File?> fileMap = _prepareFileMap();

      print('🚀 Starting vendor profile update...');
      print('📦 Body: $body');
      print('📁 Files: ${fileMap.keys.toList()}');
      print('🔑 Token: ${token.substring(0, 20)}...');
      print('👤 Is Vendor: ${AppStorage.isVendor}');

      final result = await ApiRequest.multiMultipartRequest(
        token: token,
        endPoint: ApiEndPoints.providerUpdateProfile,
        reqType: "PATCH",
        isLoading: isLoading,
        body: body,
        files: fileMap,
        fromJson: ProviderUpdateProfileModel.fromJson,
        showSuccessSnackBar: true,
        onSuccess: (response) {
          _handleSuccessResponse(response);
        },
      );

      print('✅ Profile update Request successfully');
    } catch (e) {
      _handleError(e);
    }
  }

  String? _getAuthToken() {
    final token = AppStorage.token;
    if (token.isEmpty) {
      _showSnackBar('Please login again', isError: true);
      Get.offAllNamed(Routes.loginScreen);
      return null;
    }
    return token;
  }

  bool _isUserVendor() {
    return AppStorage.isVendor;
  }

  Map<String, dynamic> _prepareRequestBody() {
    return {
      'companyName': nameController.text.trim(),
      'contactPerson': contactPersonController.text.trim(),
      'website': websiteController.text.trim(),
      'coveredRadius': coveredRadius.text.trim(),
      "latitude": selectedLatLng.value!.latitude.toString(),
      "longitude": selectedLatLng.value!.longitude.toString(),
      "serviceCategories": selectedServiceList,
      "serviceLocation": selectedAddress.value,
    };
  }

  Map<String, File?> _prepareFileMap() {
    final Map<String, File?> fileMap = {};
    if (selectedImg.value != null) {
      fileMap['profile_image'] = selectedImg.value;
    }
    return fileMap;
  }

  void _handleSuccessResponse(ProviderUpdateProfileModel response) {
    print('🎉 Success Response:');
    print('   Status Code: ${response.statusCode}');
    print('   Success: ${response.success}');
    print('   Message: ${response.message}');
    print('   Data Message: ${response.data.message}');

    // Show success message
    // _showSnackBar(response.message, isError: false);
    Get.close(1);
  }

  void _handleError(dynamic error) {
    print('❌ Vendor profile update error: $error');
    print('❌ Error type: ${error.runtimeType}');

    final errorString = error.toString();

    if (errorString.contains('not authorized') ||
        errorString.contains('401') ||
        errorString.contains('500') ||
        errorString.contains('role')) {
      _handleAuthorizationError();
    } else if (errorString.contains('timeout') ||
        errorString.contains('socket')) {
      _showSnackBar(
        'Network error. Please check your connection.',
        isError: true,
      );
    } else {
      _showSnackBar('Failed to update profile: $error', isError: true);
    }
  }

  void _handleAuthorizationError() {
    _showSnackBar('Session expired. Please login again.', isError: true);

    // FIXED: Using correct clear method
    AppStorage.clear();

    Future.delayed(Duration(milliseconds: 1500), () {
      Get.offAllNamed(Routes.loginScreen);
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (isError) {
      CustomSnackBar.error(message);
    } else {
      CustomSnackBar.success(title: message, message: message);
    }
  }

  // Utility method to check if form is valid
  bool get isFormValid {
    return nameController.text.isNotEmpty &&
        contactPersonController.text.isNotEmpty &&
        selectedLatLng.value != null &&
        selectedServiceList.isNotEmpty;
  }
}
