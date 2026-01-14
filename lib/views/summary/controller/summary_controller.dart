import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/themes/token.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/dimensions.dart';

class SummaryController extends GetxController {
  final TextEditingController noteController = TextEditingController();
  final RxList<File> selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  final RxBool isLoading = false.obs;

  // Pick multiple images from gallery
  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        selectedImages.addAll(images.map((e) => File(e.path)));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick images',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CustomColors.rejected,
        colorText: CustomColors.whiteColor,
      );
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        selectedImages.add(File(image.path));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CustomColors.rejected,
        colorText: CustomColors.whiteColor,
      );
    }
  }

  // Remove image from list
  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  // Show image source bottom sheet
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
                pickImagesFromGallery();
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

  // Validate and submit
  Future<void> submitCompletion() async {
    if (selectedImages.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please attach at least one image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CustomColors.rejected,
        colorText: CustomColors.whiteColor,
      );
      return;
    }

    try {
      isLoading.value = true;

      // TODO: Your API call here
      // Example:
      // await apiService.markAsComplete(
      //   images: selectedImages,
      //   notes: noteController.text,
      // );

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      Get.back(); // Close dialog
      Get.snackbar(
        'Success',
        'Task marked as complete!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CustomColors.primary,
        colorText: CustomColors.whiteColor,
      );

      // Clear data
      clearData();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CustomColors.rejected,
        colorText: CustomColors.whiteColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear all data
  void clearData() {
    selectedImages.clear();
    noteController.clear();
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
