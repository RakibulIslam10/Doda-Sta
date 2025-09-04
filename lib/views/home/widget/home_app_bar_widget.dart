part of '../screen/home_screen.dart';

class HomeAppBarWidgetView extends GetView<HomeController> {
  const HomeAppBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.find<NavigationController>().goToProfile(),
              child: SvgPicture.asset(Assets.logo.appLogo, height: 50.h),
            ),
            Space.width.v10,
            Column(
              crossAxisAlignment: crossStart,
              mainAxisAlignment: mainCenter,
              children: [
                Wrap(
                  children: [
                    TextWidget(
                      "Hello ",
                      color: CustomColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    TextWidget("Chime Alozie", fontWeight: FontWeight.w500),
                  ],
                ),
                TextWidget(
                  'Welcome Back',
                  fontSize: Dimensions.titleSmall,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
