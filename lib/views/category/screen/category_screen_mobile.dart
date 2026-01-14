part of 'category_screen.dart';

class CategoryScreenMobile extends GetView<CategoryController> {
  const CategoryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: Dimensions.appBarHeight * 1.6,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.defaultHorizontalSize,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.find<NavigationController>().goToProfile(),
                  child: Image.asset(Assets.logo.aaplogo.path, height: 55),
                ),
                TextWidget(
                  'My Verified Service',
                  color: CustomColors.blackColor,
                  fontSize: Dimensions.titleMedium * 1.2,
                  fontWeight: FontWeight.w600,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.notificationScreen),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: Dimensions.defaultHorizontalSize,
                    ),
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
      body: SafeArea(child: ExpandableCardList()),
    );
  }
}

class ExpandableCardList extends GetView<CategoryController> {
  const ExpandableCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: controller.allCategory.length,
        itemBuilder: (context, index) {
          final category = controller.allCategory[index];
          return GestureDetector(
            onTap: () => controller.toggleExpand(category.id ?? ""),
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
                            category.name ?? "Unnamed Category",
                            // Display category name
                            fontSize: Dimensions.titleSmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(() {
                          final isExpanded =
                              controller.expandedCategoryId.value ==
                              category.id;
                          return Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: CustomColors.primary,
                          );
                        }),
                      ],
                    ),
                    Obx(() {
                      final isExpanded =
                          controller.expandedCategoryId.value == category.id;
                      return isExpanded
                          ? Column(
                              children: [
                                const SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var subcategory
                                        in category.subcategories ?? [])
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: TextWidget(
                                          "➤ ${subcategory.name ?? 'Unnamed Subcategory'}",
                                          // Subcategory name
                                          color: CustomColors.blackColor
                                              .withAlpha(200),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            )
                          : SizedBox();
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
