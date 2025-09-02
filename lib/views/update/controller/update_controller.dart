import 'dart:io';
import 'package:get/get.dart';
import '../../../core/utils/basic_import.dart';
import '../../../widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';


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
}
