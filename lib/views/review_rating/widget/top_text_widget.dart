part of '../screen/review_rating_screen.dart';

class TopTextWidget extends GetView<ReviewRatingController> {
  const TopTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalReviews = controller.totalReviews.value;
      final avgRating = controller.rating.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            '$totalReviews Ratings',
            color: CustomColors.primary,
          ),
          Space.height.v5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBarIndicator(
                rating: avgRating,
                itemCount: 5,
                itemSize: Dimensions.iconSizeLarge * 0.95,
                direction: Axis.horizontal,
                unratedColor: CustomColors.secondary,
                itemBuilder: (context, index) {
                  if (index < avgRating.floor()) {
                    return Icon(Icons.star, color: CustomColors.primary);
                  } else if (index < avgRating) {
                    return Icon(Icons.star_half, color: CustomColors.primary);
                  } else {
                    return Icon(Icons.star_border, color: CustomColors.secondary);
                  }
                },
              ),
              TextWidget(
                avgRating.toStringAsFixed(1),
                fontWeight: FontWeight.w800,
                fontSize: Dimensions.titleLarge,
                color: CustomColors.primary,
              ),
            ],
          ),
          Space.height.v10,
          TextWidget(
            "Reviews",
            fontWeight: FontWeight.w800,
            fontSize: Dimensions.titleLarge,
          ),
          Space.height.v10,
        ],
      );
    });
  }
}
