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
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              controller: controller.companyNameController,
              hintText: 'Enter your company name',
              label: 'Company Name',
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              controller: controller.linkController,
              hintText: 'website link',
              label: 'Web site',
            ),
            Space.height.betweenInputBox,

            CustomDropDownWidget(
              hint: 'Select Category',
              label: "Category",
              items: ["Pending", "Ongoing", "Completed"],
              onChanged: (value) {
                controller.selectedCategory.value = value;
              },
            ),
            Space.height.betweenInputBox,
            CustomDropDownWidget(
              hint: 'Select Sub Category',
              label: "Sub Category",
              items: ["Pending", "Ongoing", "Completed"],
              onChanged: (value) {
                controller.selectedSubCategory.value = value;
              },
            ),

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

            Wrap(
              spacing: Dimensions.widthSize,
              runSpacing: Dimensions.heightSize * 0.5,
              children: List.generate(
                controller.dayList.length,
                (index) => InkWell(
                  onTap: () {
                    controller.selectTap(index);
                    print(controller.selectedDay);
                  },
                  child: Container(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: Dimensions.defaultHorizontalSize,
                      vertical: Dimensions.verticalSize * 0.2,
                    ),
                    decoration: BoxDecoration(
                      color: controller.dayList[index] == index? CustomColors.primary : CustomColors.primary.withAlpha(852),
                      borderRadius: BorderRadiusGeometry.circular(
                        Dimensions.radius * 0.6,
                      ),
                    ),
                    child: TextWidget(
                      controller.dayList[index],
                      color: CustomColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),

            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              controller: controller.serviceLocationController,
              hintText: 'Enter Service Location',
              label: 'Service Location',
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              controller: controller.contactPersonController,
              hintText: 'Enter Name of contact person',
              label: 'Contact Person',
            ),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            PrimaryButtonWidget(
              title: 'Sign Up',
              onPressed: () => Get.offAllNamed(Routes.navigationScreen),
            ),
          ],
        ),
      ),
    );
  }
}
