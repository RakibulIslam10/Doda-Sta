part of 'vendor_profile_screen.dart';

class VendorProfileScreenMobile extends GetView<VendorProfileController> {
  const VendorProfileScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    // final profileInfo = controller.providerUpdateProfileModel.data;

    return Scaffold(
      appBar: CommonAppBar(title: 'Edit Profile'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.v20,
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/200/300?random=',
                      height: 110.h,
                      // make height = width
                      width: 110.h,
                      // use same value for width
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey.shade300),
                      errorWidget: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: 110.h,
                        color: CustomColors.secondary,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 4,
                    right: 0,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.pickImg();
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.paddingSize * 0.1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CustomColors.whiteColor.withAlpha(88),
                          ),
                          color: CustomColors.primary,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: CustomColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              label: "Company Name",
              controller: controller.nameController,
              focusNode: controller.nameFocus,
              hintText: "Enter your companyName",
            ),

            Space.height.betweenInputBox,

            PrimaryInputFieldWidget(
              controller: controller.contactPersonController,
              hintText: 'Enter Name of contact person',
              label: 'Contact Person',
            ),
            Space.height.betweenInputBox,

            PrimaryInputFieldWidget(
              controller: controller.coveredRadius,
              hintText: 'Enter Covered Aria Km',
              label: 'Covered Aria Km',
              keyBoardType: TextInputType.number,
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              controller: controller.websiteController,
              hintText: 'Enter website Link',
              label: 'Website Link',
              keyBoardType: TextInputType.number,
            ),
            Space.height.betweenInputBox,

            PrimaryInputFieldWidget(
              label: "Location",
              controller: controller.locationController,
              focusNode: null,
              nextFocusNode: controller.numberFocus,
              hintText: "Enter your Location",
            ),
            Space.height.betweenInputBox,

            CustomDropDownWidget(
              label: 'Service Category',
              hint: 'Select Service Category',
              // show the name in the dropdown
              items: controller.serviceCategoryList.map((e) => e.name).toList(),
              onChanged: (value) {
                var selectedItem = controller.serviceCategoryList.firstWhere(
                  (element) => element.name == value,
                );
                controller.selectedServiceList.add(selectedItem.id);
              },
            ),

            //
            // MultiSelectDropDownWidget(
            //   items: controller.serviceCategoryList
            //       .map((e) => e.name)
            //       .toList(),
            //   label: "Service Category",
            //   onChanged: (List<String> selectedNames) {
            //     // Clear old selections
            //     controller.selectedServiceList.clear();
            //
            //     // Filter original list to match selected names
            //     final selectedItems = controller.serviceCategoryList
            //         .where((item) => selectedNames.contains(item.name))
            //         .toList();
            //
            //     // Add selected IDs
            //     controller.selectedServiceList.addAll(
            //       selectedItems.map((e) => e.id),
            //     );
            //
            //     print(
            //       "✅ Selected IDs: ${controller.selectedServiceList}",
            //     );
            //   },
            // ),),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            Obx(
              () => PrimaryButtonWidget(
                isLoading: controller.isLoading.value,
                title: 'Update',
                onPressed: () {
                  controller.vendorUpdateProfile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
