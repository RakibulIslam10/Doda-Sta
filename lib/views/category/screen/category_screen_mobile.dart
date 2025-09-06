part of 'category_screen.dart';

class CategoryScreenMobile extends GetView<CategoryController> {
  const CategoryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CommonAppBar(title: 'My Verified Service', isBack: false),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Column(
              crossAxisAlignment: crossCenter,
              children: [
                Space.height.v10,
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: "https://picsum.photos/200/300?random=",
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
                  "Landscaping & \n"
                  "Hardscaping Service",
                  maxLines: 2,
                  fontSize: Dimensions.titleSmall * 0.8,
                  textOverflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Space.height.v20,
            TextWidget(
              'Subcategories',
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.titleLarge * 0.8,
              padding: Dimensions.heightSize.edgeBottom,
            ),
            ListView.builder(
              cacheExtent: 500,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: crossStart,
                children: [
                  TextWidget(
                    '$index Appliance installationAppliance installation',
                    fontSize: Dimensions.titleSmall,
                  ),
                  DividerWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
