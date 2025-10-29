import 'dart:io';

import 'package:image_picker/image_picker.dart';
import '../../../core/api/services/api.dart';
import '../../../core/utils/basic_import.dart';
import '../model/provider_profile_model.dart';

class VendorProfileController extends GetxController {
  // TODO: Logic
  // name
  final nameController = TextEditingController();
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





}