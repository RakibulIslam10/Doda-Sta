part of '../screen/home_screen.dart';

class CategoryWidgetView extends GetView<HomeController> {
  const CategoryWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              'Service Categories',
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.titleMedium,
            ),
            TextWidget(
              'View All',
              onTap: () {},
              color: CustomColors.primary,
              fontSize: Dimensions.titleSmall * 0.95,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        Space.height.v10,
        SizedBox(
          height: screenHeight * 0.15,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            cacheExtent: 500,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return RepaintBoundary(
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
              );
            },
          ),
        ),
      ],
    );
  }
}
