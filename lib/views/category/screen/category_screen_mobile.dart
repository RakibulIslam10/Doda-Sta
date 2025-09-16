part of 'category_screen.dart';

class CategoryScreenMobile extends GetView<CategoryController> {
  const CategoryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
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
                  'My Verified Service',
                  color:
                  CustomColors.blackColor,
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
              ],),
          ),
        ),
      ),

      body: SafeArea(
        child:  ExpandableCardList()
      ),
    );
  }
}




class ExpandableCardList extends GetView<CategoryController> {
  const ExpandableCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      cacheExtent: 500,
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Obx(() {
          final isExpanded = controller.expandedIndex.value == index;

          return GestureDetector(
            onTap: () => controller.toggleExpand(index),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextWidget(
                            "$index Appliance installation",
                            fontSize: Dimensions.titleSmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: CustomColors.primary,
                        ),
                      ],
                    ),

                    /// Expanded Content: inner list
                    if (isExpanded) ...[
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5, // এখানে চাইলে ডাইনামিক করতে পারো
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: TextWidget(
                            "   ➤ Item ${i + 1} for card $index",
                            color: CustomColors.blackColor.withAlpha(200),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}