import 'dart:io';
import 'package:doda_work/core/api/model/basic_success_model.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/api/services/api.dart';
import '../../../core/utils/basic_import.dart';
import '../model/summary_model.dart';

class SummaryController extends GetxController {
  final TextEditingController noteController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingAccept = false.obs;

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      CustomSnackBar.error('Failed to pick image');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      CustomSnackBar.error('Failed to capture image');
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  RxString submitedProveStatus = ''.obs;

  Future<BasicSuccessModel> acceptApprove({required String id}) async {
    return await ApiRequest.patch(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: 'service-requests/update-status',
      isLoading: isLoadingAccept,
      showSuccessSnackBar: true,
      body: {'requestId': id, 'status': 'APPROVED'},
      onSuccess: (result) {
        Get.offAllNamed(Routes.navigationScreen);
      },
    );
  }

  void showImageSourceOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        decoration: BoxDecoration(
          color: CustomColors.whiteColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.radius * 2),
          ),
        ),
        child: Column(
          mainAxisSize: mainMin,
          children: [
            TextWidget(
              'Select Image Source',
              fontSize: Dimensions.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            Space.height.v20,
            ListTile(
              leading: Icon(Icons.photo_library, color: CustomColors.primary),
              title: TextWidget('Gallery', fontSize: Dimensions.bodyLarge),
              onTap: () {
                Get.back();
                pickImageFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: CustomColors.primary),
              title: TextWidget('Camera', fontSize: Dimensions.bodyLarge),
              onTap: () {
                Get.back();
                pickImageFromCamera();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitCompletion(SummaryModel model) async {
    if (selectedImage.value == null) {
      CustomSnackBar.error('Please attach an image');
      return;
    }

    await ApiRequest.multiMultipartRequest(
      reqType: 'POST',
      fromJson: BasicSuccessModel.fromJson,
      endPoint: 'service-requests/complete',
      isLoading: isLoading,
      showSuccessSnackBar: true,
      body: {'requestId': model.id ?? '', 'notes': noteController.text.trim()},
      files: {'completionProof': selectedImage.value!},
      onSuccess: (result) {
        clearData();
       Get.close(2);
      },
    );
  }

  void clearData() {
    selectedImage.value = null;
    noteController.clear();
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
