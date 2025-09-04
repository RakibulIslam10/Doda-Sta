part of 'all_category_screen.dart';

class AllCategoryScreenMobile extends GetView<AllCategoryController> {
  const AllCategoryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CommonAppBar(title: 'All Service Category'),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.verticalSize * 0.5,
          ),
          physics: const NeverScrollableScrollPhysics(),
          cacheExtent: 500,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return RepaintBoundary(
              child: InkWell(
                onTap: () => Get.toNamed(Routes.categoryPreviewScreen,arguments: {

                }),
                child: Column(
                  crossAxisAlignment: crossCenter,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://picsum.photos/200/300?random=${index + 1}",
                        width: screenWidth * 0.16,
                        height: screenWidth * 0.16,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey.shade300),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    ),
                    Space.height.v5,
                    TextWidget(
                      textAlign: TextAlign.center,
                      "Landscaping & "
                      "Hardscaping Service",
                      maxLines: 2,
                      fontSize: Dimensions.titleSmall * 0.8,
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
