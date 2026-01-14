import 'package:doda_work/views/summary/controller/summary_controller.dart';

import '../../../core/utils/basic_import.dart';

class CompleteTaskDialog extends GetView<SummaryController> {
  CompleteTaskDialog({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SummaryController());
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.6),
      ),
      child: Container(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: mainMin,
          crossAxisAlignment: crossStart,
          children: [
            // Header
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                TextWidget(
                  'Complete Task',
                  fontSize: Dimensions.headlineSmall,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    controller.clearData();
                    Get.back();
                  },
                ),
              ],
            ),
            Space.height.v20,

            // Image attachment section
            TextWidget(
              'Attach Images *',
              fontSize: Dimensions.titleMedium,
              fontWeight: FontWeight.w600,
            ),
            Space.height.v10,

            // Image picker button
            InkWell(
              onTap: () => controller.showImageSourceOptions(context),
              child: Container(
                width: double.infinity,
                height: Dimensions.inputBoxHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.disableColor),
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
                child: Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    Icon(Icons.add_photo_alternate,
                      color: CustomColors.primary,
                      size: Dimensions.iconSizeLarge,
                    ),
                    Space.width.v10,
                    TextWidget(
                      'Add Images',
                      color: CustomColors.primary,
                      fontSize: Dimensions.bodyLarge,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            Space.height.v15,

            // Selected images preview
            Obx(() {
              if (controller.selectedImages.isEmpty) {
                return SizedBox.shrink();
              }

              return Container(
                height: 120.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: Dimensions.widthSize),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.radius),
                            child: Image.file(
                              controller.selectedImages[index],
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () => controller.removeImage(index),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: CustomColors.rejected,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: Dimensions.iconSizeDefault,
                                  color: CustomColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),

            Obx(() => controller.selectedImages.isNotEmpty
                ? Space.height.v20
                : SizedBox.shrink()
            ),

            // Notes section
            TextWidget(
              'Notes (Optional)',
              fontSize: Dimensions.titleMedium,
              fontWeight: FontWeight.w600,
            ),
            Space.height.v10,
            TextField(
              controller: controller.noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add any additional notes...',
                hintStyle: TextStyle(
                  color: CustomColors.disableColor,
                  fontSize: Dimensions.bodyMedium,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  borderSide: BorderSide(color: CustomColors.disableColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  borderSide: BorderSide(color: CustomColors.disableColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  borderSide: BorderSide(color: CustomColors.primary),
                ),
              ),
            ),
            Space.height.v20,

            // Action buttons
            Obx(() => Row(
              mainAxisAlignment: mainEnd,
              children: [
                TextButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    controller.clearData();
                    Get.back();
                  },
                  child: TextWidget(
                    'Cancel',
                    color: CustomColors.secondaryDarkText,
                    fontSize: Dimensions.bodyLarge,
                  ),
                ),
                Space.width.v10,
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitCompletion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSize * 1.5,
                      vertical: Dimensions.heightSize * 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      color: CustomColors.whiteColor,
                      strokeWidth: 2,
                    ),
                  )
                      : TextWidget(
                    'Submit',
                    color: CustomColors.whiteColor,
                    fontSize: Dimensions.bodyLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}