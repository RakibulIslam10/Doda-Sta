part of '../screen/home_screen.dart';

class StatusWidgetView extends GetView<HomeController> {
  const StatusWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final List statusText = ['Pending', 'Ongoing', 'Complete'];

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: Dimensions.widthSize,
      children: List.generate(
        statusText.length,
        (index) => InkWell(
          onTap:  () {
            controller.selectedStatus.value =  index;
          },
          child: Obx(() => Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 1.2,
              vertical: Dimensions.verticalSize * 0.25,
            ),
            decoration: BoxDecoration(
              color: controller.selectedStatus.value == index ? CustomColors.primary : CustomColors.disableColor,
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            child: TextWidget(
              statusText[index],
              color: controller.selectedStatus.value == index ? CustomColors.whiteColor : CustomColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.titleSmall,
            ),
          ),),
        ),
      ),
    );
  }
}
