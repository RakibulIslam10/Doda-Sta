import 'dart:io';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/api/services/api.dart';
import '../../../core/utils/basic_import.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user_update_profile_model.dart';

class UpdateController extends GetxController {
  // name
  final nameController = TextEditingController();
  final nameFocus = FocusNode();

  // email
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final isEmailValid = false.obs;

  // number
  final numberController = TextEditingController();
  final numberFocus = FocusNode();

  final _imagePicker = ImagePicker();
  RxBool isLoading = false.obs;
  final Rx<File?> selectedImg = Rx(null);

  Future<void> pickImg() async {
    final pickedImg = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      selectedImg.value = File(pickedImg.path);
    } else {
      CustomSnackBar.error('Image not selected');
    }
  }

  final Rxn<LatLng> selectedLatLng = Rxn<LatLng>();
  final RxString selectedAddress = "".obs;

  Future<UserUpdateProfileModel?> userUpdateProfile() async {
    final Map<String, File?> fileMap = {};
    if (selectedImg.value != null) {
      fileMap['profile_image'] = selectedImg.value;
    }

    return await ApiRequest.multiMultipartRequest(
      endPoint: ApiEndPoints.userUpdateProfile,
      token: AppStorage.temporaryToken,
      reqType: "PATCH",
      isLoading: isLoading,
      body: {
        'firstName': nameController.text.trim(),
        "latitude": selectedLatLng.value?.latitude.toString() ?? "",
        "longitude": selectedLatLng.value?.longitude.toString() ?? "",
      },
      files: fileMap,
      fromJson: UserUpdateProfileModel.fromJson,
      showSuccessSnackBar: true,
      onSuccess: (_) => Get.offAllNamed(Routes.navigationScreen),
    );
  }
}
