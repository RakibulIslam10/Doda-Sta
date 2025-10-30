part of 'profile_screen.dart';

class ProfileScreenMobile extends GetView<ProfileController> {
  const ProfileScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: Dimensions.defaultHorizontalSize,
            ),
            child: Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                GestureDetector(
                  onTap: () => Get.find<NavigationController>().goToProfile(),
                  child: SvgPicture.asset(Assets.logo.appLogo, height: 45.h),
                ),
                TextWidget(
                  'Profile',
                  color: CustomColors.blackColor,
                  fontSize: Dimensions.titleMedium * 1.2,
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
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? LoadingWidget()
              : ListView(
                  padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
                  children: [
                    Space.height.betweenInputBox,
                  // if(controller.providerProfileModel.data.isActive == true)
                    ProfileTopHeaderWidgetView(),
                    Space.height.v20,
                    ProfileCardSectionWidgetView(),
                  ],
                ),
        ),
      ),
    );
  }
}
