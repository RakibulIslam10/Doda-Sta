part of '../screen/home_vendor_screen.dart';

class TabBarViewStatusWidget extends GetView<HomeVendorController> {
  const TabBarViewStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tabList = ['Pending', 'Ongoing', 'Complete', 'Declined'];

    return DefaultTabController(
      length: tabList.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);

          /// Swipe listener (instant color update)
          tabController.animation!.addListener(() {
            final int currentIndex = tabController.animation!.value.round();
            if (controller.selectedTabIndex.value != currentIndex) {
              controller.selectedTabIndex.value = currentIndex;
            }
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Custom Status TabBar
              Space.height.v20,

              Obx(
                () => TabBar(
                  controller: tabController,
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  labelPadding: EdgeInsets.zero,
                  enableFeedback: false,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: (value) => controller.selectedTabIndex.value = value,
                  splashFactory: NoSplash.splashFactory,
                  tabs: List.generate(tabList.length, (index) {
                    final bool isSelected =
                        controller.selectedTabIndex.value == index;
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.defaultHorizontalSize * 0.4,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.widthSize,
                        vertical: Dimensions.verticalSize * 0.3,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? CustomColors.primary
                            : CustomColors.primary.withAlpha(858),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius * 0.8,
                        ),
                      ),
                      child: Center(
                        child: TextWidget(
                          tabList[index],
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.titleSmall * 0.95,
                          color: isSelected
                              ? CustomColors.whiteColor
                              : CustomColors.blackColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Space.height.v15,

              Expanded(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(
                    bottom: Dimensions.verticalSize * 0.5,
                  ),
                  child: TabBarView(
                    controller: tabController,
                    physics: const ClampingScrollPhysics(),

                    children: [
                      /// Pending
                      CustomScrollView(
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => VendorStatusCardWidget(
                                index: index,
                                category: 'Category $index',
                                subCategory: 'SubCategory $index',
                                dateTime: 'PFri 28 Sep25/ at 11:30 am -12:00pm',
                              ),
                              childCount: 10,
                            ),
                          ),
                        ],
                      ),

                      /// Ongoing
                      CustomScrollView(
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => VendorStatusCardWidget(
                                index: index,
                                category: 'Category $index',
                                subCategory: 'SubCategory $index',
                                dateTime: 'PFri 28 Sep25/ at 11:30 am -12:00pm',
                              ),
                              childCount: 10,
                            ),
                          ),
                        ],
                      ),

                      /// Complete
                      CustomScrollView(
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => VendorStatusCardWidget(
                                index: index,
                                category: 'Category $index',
                                subCategory: 'SubCategory $index',
                                dateTime: 'PFri 28 Sep25/ at 11:30 am -12:00pm',
                              ),
                              childCount: 10,
                            ),
                          ),
                        ],
                      ),

                      CustomScrollView(
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => VendorStatusCardWidget(
                                index: index,
                                category: 'Category $index',
                                subCategory: 'SubCategory $index',
                                dateTime: 'PFri 28 Sep25/ at 11:30 am -12:00pm',
                              ),
                              childCount: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
