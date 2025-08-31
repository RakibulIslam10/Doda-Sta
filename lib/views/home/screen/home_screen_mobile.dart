part of 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.appBarHeight * 1.25,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
            child: Row(
              children: [
                SvgPicture.asset(Assets.logo.appLogo, height: 50.h),
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
        ),
        actions: [
          Container(
            margin: Dimensions.defaultHorizontalSize.edgeRight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: CustomColors.primary),
            ),
            padding: EdgeInsets.all(Dimensions.paddingSize * 0.35),
            child: SvgPicture.asset(Assets.icons.group),
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [],
        ),
      ),
    );
  }
}
