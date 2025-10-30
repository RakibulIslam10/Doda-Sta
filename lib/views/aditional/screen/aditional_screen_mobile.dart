part of 'aditional_screen.dart';

class AditionalScreenMobile extends GetView<AditionalController> {
  const AditionalScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(controller.getAvailabilityData()));
    print(Get.find<RegisterController>().nameController.text);
    return Scaffold(
      appBar: CommonAppBar(title: 'Service Provider registration'),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingWidget()
            : SafeArea(
                child: ListView(
                  padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
                  children: [
                    // PrimaryInputFieldWidget(
                    //   controller: controller.companyNameController,
                    //   hintText: 'Company Name',
                    //   label: 'Company Name',
                    // ),
                    // Space.height.betweenInputBox,
                    PrimaryInputFieldWidget(
                      controller: controller.linkController,
                      hintText: 'website link',
                      label: 'Web site',
                    ),
                    Space.height.betweenInputBox,

                    MultiSelectDropDownWidget(
                      items: controller.serviceCategoryList
                          .map((e) => e.name)
                          .toList(),
                      label: "Service Category",
                      onChanged: (List<String> selectedNames) {
                        // Clear old selections
                        controller.selectedServiceList.clear();

                        // Filter original list to match selected names
                        final selectedItems = controller.serviceCategoryList
                            .where((item) => selectedNames.contains(item.name))
                            .toList();

                        // Add selected IDs
                        controller.selectedServiceList.addAll(
                          selectedItems.map((e) => e.id),
                        );

                        print(
                          "✅ Selected IDs: ${controller.selectedServiceList}",
                        );
                      },
                    ),
                    Space.height.betweenInputBox,
                    TextWidget(
                      'Select day and set time',
                      fontSize: Dimensions.titleSmall,
                      padding: Dimensions.heightSize.edgeBottom * 0.4,
                    ),

                    Obx(
                      () => Wrap(
                        spacing: Dimensions.widthSize,
                        runSpacing: Dimensions.heightSize * 0.5,
                        children: List.generate(controller.dayList.length, (
                          index,
                        ) {
                          final day = controller.dayList[index];
                          final isEditing =
                              controller.currentEditingDay.value == day;
                          final hasTime = controller.isDaySelected(day);

                          return InkWell(
                            onTap: () {
                              controller.selectTap(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.defaultHorizontalSize,
                                vertical: Dimensions.verticalSize * 0.2,
                              ),
                              decoration: BoxDecoration(
                                color: isEditing
                                    ? CustomColors
                                          .primary // Currently editing
                                    : hasTime
                                    ? CustomColors.primary.withOpacity(
                                        0.5,
                                      ) // Has time
                                    : CustomColors.primary.withOpacity(0.2),
                                // No time
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius * 0.6,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextWidget(
                                    day,
                                    color: isEditing || hasTime
                                        ? CustomColors.whiteColor
                                        : CustomColors.primary,
                                  ),
                                  // ✅ Show remove icon if has time
                                  if (hasTime && !isEditing) ...[
                                    SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () =>
                                          controller.removeDayAvailability(day),
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: CustomColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    Space.height.betweenInputBox,

                    // ✅ Show time pickers only when a day is selected
                    Obx(() {
                      if (controller.currentEditingDay.isEmpty) {
                        return SizedBox.shrink();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            'Set time for ${controller.currentEditingDay.value}',
                            fontSize: Dimensions.titleSmall,
                            padding: Dimensions.heightSize.edgeBottom * 0.4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TimePickerWidget(
                                  label: 'Start Time',
                                  /*onTimeSelected: (time) {
                                    controller.startedTime.value = time;
                                    controller
                                        .saveTimeForCurrentDay(); // ✅ Auto save
                                  },*/
                                ),
                              ),
                              Space.width.v10,
                              Expanded(
                                child: TimePickerWidget(
                                  label: 'End Time',
                                  /*onTimeSelected: (time) {
                                    controller.endTime.value = time;
                                    controller
                                        .saveTimeForCurrentDay(); // ✅ Auto save
                                  },*/
                                ),
                              ),
                            ],
                          ),
                          Space.height.betweenInputBox,
                        ],
                      );
                    }),

                    // ✅ Show saved availability
                    Obx(() {
                      final availableDays = controller.getAvailabilityData();
                      if (availableDays.isEmpty) return SizedBox.shrink();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            'Your Availability:',
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.titleSmall,
                          ),
                          SizedBox(height: 8),
                          ...availableDays.map(
                            (item) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  TextWidget(
                                    '${item['day']}: ',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidget(
                                    '${item['startTime']} - ${item['endTime']}',
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => controller
                                        .removeDayAvailability(item['day']),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Space.height.betweenInputBox,
                        ],
                      );
                    }),

                    // PrimaryInputFieldWidget(
                    //   controller: controller.serviceLocationController,
                    //   hintText: 'Enter Register Address',
                    //   label: 'Register Address',
                    // ),
                    Obx(() {
                      final isPick = controller.selectedAddress.isNotEmpty;
                      return GestureDetector(
                        onTap: () {
                          _openPicker(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isPick
                                  ? CustomColors.primary
                                  : CustomColors.disableColor,
                              width: 1.4,
                            ),
                          ),
                          child: Text(
                            isPick
                                ? controller.selectedAddress.value
                                : "Pick Service Address",
                            style: TextStyle(
                              fontSize: Dimensions.titleSmall,
                              fontWeight: FontWeight.w500,
                              color: isPick
                                  ? CustomColors.blackColor
                                  : CustomColors.blackColor.withAlpha(888),
                            ),
                          ),
                        ),
                      );
                    }),

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
                    Obx(
                      () => PrimaryButtonWidget(
                        title: 'Registration',
                        isLoading: controller.providerRegIsLoading.value,
                        onPressed: () {
                          controller.providerRegisterProcess();
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _openPicker(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapLocationPicker(
          config: MapLocationPickerConfig(
            apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894",
            onNext: (result) {
              if (result != null &&
                  result.geometry?.location.lat != null &&
                  result.geometry?.location.lat != null) {
                controller.selectedLatLng.value = LatLng(
                  result.geometry!.location.lat,
                  result.geometry!.location.lng,
                );

                controller.selectedAddress.value =
                    result.formattedAddress ?? "";
              }
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          geoCodingConfig: GeoCodingConfig(
            apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894",
          ),
          searchConfig: SearchConfig(
            apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894",
          ),
        ),
      ),
    );
  }
}
