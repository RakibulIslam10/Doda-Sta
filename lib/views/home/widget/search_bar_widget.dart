part of '../screen/home_screen.dart';

class SearchBarWidgetView extends GetView<HomeController> {
  const SearchBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.verticalSize * 0.8,

        horizontal: Dimensions.defaultHorizontalSize,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.primary, width: 1.4),
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
      ),
      height: Dimensions.inputBoxHeight * 0.7,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.defaultHorizontalSize * 0.5,
            ),
            child: Icon(
              CupertinoIcons.search,
              color: CustomColors.primary,
              size: Dimensions.iconSizeLarge,
            ),
          ),
          TextWidget('Search', color: CustomColors.grayShade.withAlpha(885)),
        ],
      ),
    );
  }
}
