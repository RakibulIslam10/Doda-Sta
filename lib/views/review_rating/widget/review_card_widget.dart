part of '../screen/review_rating_screen.dart';

class ReviewCardWidget extends StatelessWidget {
  final String reviewerName;
  final String reviewerImage; // new
  final double rating;
  final String comment;
  final String date;

  const ReviewCardWidget({
    super.key,
    required this.reviewerName,
    required this.reviewerImage, // new
    required this.rating,
    required this.comment, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // top-align image
        children: [
          // Reviewer Image
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: reviewerImage,
              width: 44.w,
              height: 40.h,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade300),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                TextWidget(
                  reviewerName,
                  color: CustomColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                Space.height.v5,

                // Rating stars
                RatingBarIndicator(
                  rating: rating,
                  itemCount: 5,
                  unratedColor: CustomColors.secondary,
                  itemSize: Dimensions.iconSizeLarge * 0.75,
                  direction: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index < rating.floor()) {
                      return Icon(Icons.star, color: CustomColors.primary);
                    } else if (index < rating) {
                      return Icon(Icons.star_half, color: CustomColors.primary);
                    } else {
                      return Icon(
                        Icons.star_border,
                        color: CustomColors.secondary,
                      );
                    }
                  },
                ),
                Space.height.v5,

                Space.height.v5,

                // Comment
                TextWidget(
                  comment,
                  fontSize: Dimensions.titleSmall,
                  color: Colors.grey.shade700,
                ),
              ],
            ),
          ),

          TextWidget(date, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
