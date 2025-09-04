part of '../screen/request_screen.dart';

class OthersFieldWidget extends GetView<RequestController> {
  const OthersFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
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
        PrimaryInputFieldWidget(
          controller: controller.serviceAddressController,
          hintText: 'Enter Services Address',
          label: 'Services Address',
          maxLines: 3,
        ),
        Space.height.betweenInputBox,
        PrimaryInputFieldWidget(
          controller: controller.requestController,
          hintText: 'Enter your request',
          label: 'Would you like to tell us more about your request?',
          maxLines: 4,
        ),



      ],
    );
  }
}
