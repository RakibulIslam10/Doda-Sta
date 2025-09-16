part of '../screen/request_screen.dart';

class OthersFieldWidget extends GetView<RequestController> {
  const OthersFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        MultiSelectDropDownWidget(
          items: ["Apple", "Banana", "Mango", "Orange", "Grapes"],
          label: "Service Category", onChanged: (List<String> p1) { },
        ),
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
          hintText: 'Enter Location of service.',
          label: 'Location of service.',
          maxLines: 3,
        ),
        Space.height.betweenInputBox,
        PrimaryInputFieldWidget(
          controller: controller.requestController,
          hintText: 'Enter your request',
          label: 'Please describe the issue in detail.',
          maxLines: 4,
        ),



      ],
    );
  }
}
