part of '../screen/request_screen.dart';

class OthersFieldWidget extends GetView<RequestController> {
  const OthersFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        // CustomDropDownWidget(
        //   hint: 'Select Category',
        //   label: "Service Category",
        //   items: ["Pending", "Ongoing", "Completed"],
        //   onChanged: (value) {
        //     controller.selectedCategory.value = value;
        //   },
        // ),
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
        PrimaryInputFieldWidget(
          controller: controller.serviceAddressController,
          hintText: 'What is the service address',
          label: 'What is the service address',
          maxLines: 3,
        ),
        Space.height.betweenInputBox,
        PrimaryInputFieldWidget(
          controller: controller.requestController,
          hintText: 'Please describe the issue in detail',
          label: 'Please describe the issue in detail.',
          maxLines: 4,
        ),
      ],
    );
  }
}
