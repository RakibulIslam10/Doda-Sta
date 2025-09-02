part of 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> statusText = ['Pending', 'Ongoing', 'Complete'];

    return DefaultTabController(
      length: statusText.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);

          // Swipe listener (instant color update)
          tabController.animation!.addListener(() {
            final int currentIndex = tabController.animation!.value.round();
            if (controller.selectedStatus.value != currentIndex) {
              controller.selectedStatus.value = currentIndex;
            }
          });

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

                  /// Custom Status TabBar
                  Obx(
                    () => TabBar(
                      controller: tabController,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelPadding: EdgeInsets.zero,
                      enableFeedback: false,
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                      onTap: (value) => controller.selectedStatus.value = value,
                      splashFactory: NoSplash.splashFactory,
                      tabs: List.generate(statusText.length, (index) {
                        final bool isSelected =
                            controller.selectedStatus.value == index;
                        return Container(
                          margin: EdgeInsets.only(
                            right: Dimensions.widthSize * 1.5,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.widthSize * 1.2,
                            vertical: Dimensions.verticalSize * 0.4,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? CustomColors.primary
                                : CustomColors.disableColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius * 0.8,
                            ),
                          ),
                          child: Center(
                            child: TextWidget(
                              statusText[index],
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.titleSmall,
                              color: isSelected
                                  ? CustomColors.whiteColor
                                  : CustomColors.blackColor,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  Space.height.v10,

                  /// TabBarView content
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Center(child: TextWidget("Pending Content")),
                        Center(child: TextWidget("Ongoing Content")),
                        Center(child: TextWidget("Complete Content")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
