part of '../screen/review_rating_screen.dart';

class TopTextWidget extends GetView<ReviewRatingController> {
  const TopTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget('235 Ratings', color: CustomColors.primary),

        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            RatingBarIndicator(
              rating: controller.totalRating.value,
              itemCount: 5,
              itemSize: Dimensions.iconSizeLarge * 0.95,
              direction: Axis.horizontal,
              unratedColor: CustomColors.secondary,

              itemBuilder: (context, index) {
                if (index < controller.totalRating.value.floor()) {
                  return Icon(Icons.star, color: CustomColors.primary);
                } else if (index < controller.totalRating.value) {
                  return Icon(Icons.star_half, color: CustomColors.primary);
                } else {
                  return Icon(
                    Icons.star_border,
                    color: CustomColors.secondary,
                  );
                }
              },
            ),
            TextWidget(
              controller.totalRating.string,
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
  }
}
