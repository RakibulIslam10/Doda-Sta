part of 'aditional_screen.dart';

class AditionalScreenMobile extends GetView<AditionalController> {
  const AditionalScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Service Provider registration'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            // Add your widgets here
            // Space.height.betweenInputBox,
            // PrimaryInputFieldWidget(
            //   controller: controller.companyNameController,
            //   hintText: 'Enter your company name',
            //   label: 'Company Name',
            // ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              controller: controller.linkController,
              hintText: 'website link',
              label: 'Web site',
            ),
            Space.height.betweenInputBox,

            CustomDropDownWidget(
              hint: 'Select Category',
              label: "Service Category",
              items: ["Pending", "Ongoing", "Completed"],
              onChanged: (value) {
                controller.selectedCategory.value = value;
              },
            ),
            // Space.height.betweenInputBox,
            // CustomDropDownWidget(
            //   hint: 'Select Sub Category',
            //   label: "Sub Category",
            //   items: ["Pending", "Ongoing", "Completed"],
            //   onChanged: (value) {
            //     controller.selectedSubCategory.value = value;
            //   },
            // ),

            Space.height.betweenInputBox,
            TextWidget(
              'Service Date Range',
              fontSize: Dimensions.titleSmall,
              padding: Dimensions.heightSize.edgeBottom * 0.4,
            ),
            Row(
              children: [
                Expanded(
                  child: TimePickerWidget(
                    label: 'Start Time',
                    onTimeSelected: (time) {
                      controller.startedTime.value = time;
                    },
                  ),
                ),
                Space.width.v10,
                Expanded(
                  child: TimePickerWidget(
                    label: 'End Time',
                    onTimeSelected: (time) {
                      controller.endTime.value = time;
                    },
                  ),
                ),
              ],
            ),
            TextWidget(
              'Select your availability',
              padding: EdgeInsetsGeometry.symmetric(
                vertical: Dimensions.verticalSize * 0.5,
              ),
            ),

            Obx(
              () => Wrap(
                spacing: Dimensions.widthSize,
                runSpacing: Dimensions.heightSize * 0.5,
                children: List.generate(controller.dayList.length, (index) {
                  final day = controller.dayList[index];
                  final isSelected = controller.selectedDay.contains(day);

                  return InkWell(
                    onTap: () {
                      controller.selectTap(index);
                      print(controller.selectedDay);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.defaultHorizontalSize,
                        vertical: Dimensions.verticalSize * 0.2,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? CustomColors
                                  .primary // ✅ selected হলে
                            : CustomColors.primary.withOpacity(0.2),
                        // ❌ not selected হলে
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius * 0.6,
                        ),
                      ),
                      child: TextWidget(
                        day,
                        color: isSelected
                            ? CustomColors
                                  .whiteColor
                            : CustomColors.primary,
                      ),
                    ),
                  );
                }),
              ),
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              controller: controller.serviceLocationController,
              hintText: 'Enter Register Address',
              label: 'Register Address',
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              controller: controller.contactPersonController,
              hintText: 'Enter Name of contact person',
              label: 'Contact Person',
            ),
            Space.height.betweenInputBox,

            TextWidget(
              'license & certificate',
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.titleMedium,

              padding: Dimensions.heightSize.edgeBottom,
            ),

            Obx(() {
              final items = [...controller.photos];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var photo in items)
                    Container(
                      width: 100.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius * 0.8,
                        ),
                        image: DecorationImage(
                          image: FileImage(photo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Container(
                      width: 100.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius * 0.8,
                        ),
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.orange,
                          size: Dimensions.iconSizeLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),

            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            PrimaryButtonWidget(
              title: 'Registration',
              onPressed: () => Get.offAllNamed(Routes.navigationScreen),
            ),
          ],
        ),
      ),
    );
  }
}
