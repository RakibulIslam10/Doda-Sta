part of '../screen/request_screen.dart';

class OthersFieldWidget extends StatelessWidget {
  const OthersFieldWidget({
    super.key,
    required this.requestController,
    required this.phoneController,
    required this.controller,
    required this.categoryController,
  });

  final TextEditingController requestController;
  final TextEditingController phoneController;
  final RequestController controller;
  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    var apiKeyMap =  Platform.isAndroid ? "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894" : "AIzaSyDNVuOBQjhjZlxvhBtowqjYN5_YsYfqezQ";

    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Obx(() {
          if (categoryController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (categoryController.filteredCategory.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No categories found.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => categoryController.getCategory(),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Fetch Again"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDropDownWidget(
                hint: 'Select Category',
                label: "Service Category",
                items: categoryController.filteredCategory.map((c) =>
                    DropdownMenuItem<String>(
                      value: c.id,
                      child: Text(c.name ?? ''),
                    )).toList(),
                onChanged: (value) {
                  if (value != null) controller.onCategorySelected(value);
                },
                value: controller.selectedCategoryId.value.isEmpty ? null : controller
                    .selectedCategoryId.value,
              ),

              Space.height.betweenInputBox,
              CustomDropDownWidget<String>(
                hint: 'Select Subcategory',
                label: "Sub Category",
                items: categoryController.availableSubcategories.map((s) =>
                    DropdownMenuItem<String>(
                      value: s.id,
                      child: Text(s.name ?? ''),
                    )).toList(),
                onChanged: (value) {
                  if (value != null) controller.onSubCategorySelected(value);
                },
                value: controller.selectedSubCategoryId.value.isEmpty
                    ? null
                    : controller.selectedSubCategoryId.value,
              ),
            ],
          );
        }),
        Space.height.betweenInputBox,
        CustomDropDownWidget<String>(
          hint: 'Select your service priority',
          label: "Service Priority",
          value: controller.selectedPriority.value.isEmpty
              ? null
              : controller.selectedPriority.value,
          items: [
            DropdownMenuItem<String>(value: "Low", child: Text("Low")),
            DropdownMenuItem<String>(value: "Normal", child: Text("Normal")),
            DropdownMenuItem<String>(value: "Urgent", child: Text("Urgent")),
          ],
          onChanged: (value) {
            if (value != null) {
              controller.selectedPriority.value = value;
            }
          },
        ),
        Space.height.betweenInputBox,
        Row(
          children: [
            TextWidget(
              "What is the service address",
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              fontSize: Dimensions.titleSmall,
              fontWeight: FontWeight.w500,
              color: CustomColors.blackColor.withAlpha(888),
            ),
          ],
        ),
        SizedBox(height: Dimensions.spaceBetweenInputTitleAndBox * 0.6),
        Obx(() {
          final isPick = controller.selectedAddress.isNotEmpty;
          return GestureDetector(
            onTap: () {
              _openPicker(context,apiKeyMap);
            },
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isPick? CustomColors.primary :CustomColors.disableColor, width: 1.4),
              ),
              child: Text( isPick ? controller.selectedAddress.value : "Pick Service Address",
                style: TextStyle(
                  fontSize: Dimensions.titleSmall,
                  fontWeight: FontWeight.w500,
                  color: isPick ? CustomColors.blackColor :CustomColors.blackColor.withAlpha(888),
                ),
              ),
            ),
          );
        }),
        Space.height.betweenInputBox,
        PrimaryInputFieldWidget(
          controller: requestController,
          hintText: 'Please describe the issue in detail',
          label: 'Please describe the issue in detail.',
          maxLines: 4,
        ),
        Space.height.betweenInputBox,
        PrimaryInputFieldWidget(
          controller: phoneController,
          hintText: 'Please Enter your contact Number',
          label: 'Contact Number',
        ),
      ],
    );
  }

  void _openPicker(BuildContext context, String apiKey) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MapLocationPicker(
              config: MapLocationPickerConfig(
                apiKey: apiKey,
                onNext: (result) {
                  if (result != null && result.geometry?.location.lat != null &&
                      result.geometry?.location.lat != null) {
                    controller.selectedLatLng.value = LatLng(
                      result.geometry!.location.lat,
                      result.geometry!.location.lng,
                    );

                    controller.selectedAddress.value = result.formattedAddress ?? "";
                    // controller.fetchPostalCode();
                  }
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
              geoCodingConfig: GeoCodingConfig(
                  apiKey: apiKey
              ),
              searchConfig: SearchConfig(
                apiKey: apiKey,
              ),
            ),
      ),
    );
  }
}
