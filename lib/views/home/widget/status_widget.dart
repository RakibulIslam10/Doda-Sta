part of '../screen/home_screen.dart';

class StatusWidgetView extends GetView<HomeController> {
  const StatusWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> statusText = ['Pending', 'Ongoing', 'Completed'];

    return DefaultTabController(
      length: statusText.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);

          /// Swipe listener (instant color update)
          tabController.animation!.addListener(() {
            final int currentIndex = tabController.animation!.value.round();
            if (controller.selectedStatus.value != currentIndex) {
              controller.selectedStatus.value = currentIndex;
            }
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                        vertical: Dimensions.verticalSize * 0.32,
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
              Space.height.v15,

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.38,
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
                              (context, index) => CustomStatusCardWidget(
                                index: index,
                                requestId: 'Pending-${index + 1}',
                                category: 'Category $index',
                                subCategory: 'SubCategory $index',
                                address: 'Pending Address $index',
                                status: 'Pending',
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
                              (context, index) => CustomStatusCardWidget(
                                index: index,
                                requestId: 'Ongoing-${index + 1}',
                                category: 'Category $index',
                                subCategory: 'SubCategory $index',
                                address: 'Ongoing Address $index',
                                status: 'Ongoing',
                              ),
                              childCount: 2,
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
                              (context, index) => CustomStatusCardWidget(
                                index: index,
                                requestId: 'Complete-${index + 1}',
                                category: 'Category $index',
                                subCategory: 'SubCategory $index',
                                address: 'Complete Address $index',
                                status: 'Complete',
                              ),
                              childCount: 1,
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
