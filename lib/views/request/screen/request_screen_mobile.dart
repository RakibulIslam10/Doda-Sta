part of 'request_screen.dart';

class RequestScreenMobile extends GetView<RequestController> {
  const RequestScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: Dimensions.appBarHeight * 1.6,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: Dimensions.defaultHorizontalSize),
            child: Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                GestureDetector(
                  onTap: () => Get.find<NavigationController>().goToProfile(),
                  child: SvgPicture.asset(Assets.logo.appLogo, height: 45.h),
                ),
                TextWidget(
                  'Book a Service Appointment',
                  color:
                  CustomColors.blackColor,
                  fontSize: Dimensions.titleMedium,
                  fontWeight: FontWeight.w600,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.notificationScreen),
                  child: Container(
                    margin: Dimensions.defaultHorizontalSize.edgeRight,
                    padding: EdgeInsets.all(Dimensions.paddingSize * 0.35),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: CustomColors.primary),
                    ),
                    child: SvgPicture.asset(Assets.icons.group),
                  ),
                ),
              ],),
          ),
        ),
      ),


      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            TimeAndDateSectionWidget(),
            Space.height.betweenInputBox,
            OthersFieldWidget(),
            Space.height.betweenInputBox,

            AddPhotoGrid(),
            Space.height.betweenInputBox,

            PrimaryButtonWidget(
              title: "Submit",
              onPressed: () {
                Get.toNamed(Routes.summaryScreen);
              },
            ),

            Space.height.betweenInputBox,
          ],
        ),
      ),
    );
  }
}
