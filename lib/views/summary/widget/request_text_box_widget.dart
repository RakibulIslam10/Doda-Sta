part of '../screen/summary_screen.dart';

class RequestTextBoxWidget extends GetView<SummaryController> {
  const RequestTextBoxWidget({this.description, super.key});
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: Dimensions.verticalSize * 0.25,
          ),
          'request?',
          color: CustomColors.grayShade,
        ),
        Container(
          padding: EdgeInsets.all(Dimensions.paddingSize * 0.25),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.disableColor),
            borderRadius: BorderRadiusGeometry.circular(
              Dimensions.radius * 0.8,
            ),
          ),
          child: TextWidget(
            fontSize: Dimensions.titleSmall,
            color: CustomColors.grayShade,
            description ?? "",
          ),
        ),
      ],
    );
  }
}
