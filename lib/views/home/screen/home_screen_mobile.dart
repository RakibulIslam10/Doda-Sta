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
          physics: NeverScrollableScrollPhysics(),
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            const SearchBarWidgetView(),
            const CategoryWidgetView(),
            const StatusWidgetView(),
            Space.height.v10,
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsetsGeometry.only(
                      bottom: Dimensions.verticalSize * 0.5,
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      color: CustomColors.whiteColor,

                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
