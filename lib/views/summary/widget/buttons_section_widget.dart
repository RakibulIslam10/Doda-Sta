part of '../screen/summary_screen.dart';

class ButtonsSectionWidget extends GetView<SummaryController> {
  const ButtonsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Space.height.betweenInputBox,
        PrimaryButtonWidget(
          borderWidth: 1.4,
          outlineButton: true,
          title: 'Edit',
          onPressed: () {
            Get.showSnackbar(GetSnackBar(title: 'Hell'));
          },
        ),
        Space.height.betweenInputBox,
        PrimaryButtonWidget(
          title: 'Get Matched',
          onPressed: () {
            Get.showSnackbar(GetSnackBar(title: 'Hell'));
          },
        ),
      ],
    );
  }
}
