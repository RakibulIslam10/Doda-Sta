part of 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.appBarHeight * 1.25),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: const HomeAppBarWidgetView(),
          actions: [
            Container(
              margin: Dimensions.defaultHorizontalSize.edgeRight,
              padding: EdgeInsets.all(Dimensions.paddingSize * 0.35),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: CustomColors.primary),
              ),
              child: SvgPicture.asset(Assets.icons.group),
            ),
            Space.width.v10,
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          physics: NeverScrollableScrollPhysics(),
          children: [
            const SearchBarWidgetView(),
            const CategoryWidgetView(),
            const StatusWidgetView(),

          ],
        ),
      ),
    );
  }
}
