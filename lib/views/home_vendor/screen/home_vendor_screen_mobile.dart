part of 'home_vendor_screen.dart';

class HomeVendorScreenMobile extends GetView<HomeVendorController> {
  const HomeVendorScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.appBarHeight * 1.25),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: const HomeAppBarWidgetView(),
          actions: [
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
            Space.width.v10,
          ],
        ),
      ),
      body: SafeArea(child: TabBarViewStatusWidget()),
    );
  }
}
