part of 'review_rating_screen.dart';

class ReviewRatingScreenMobile extends GetView<ReviewRatingController> {
  const ReviewRatingScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Customer Review'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            TopTextWidget(),

            // List of reviews
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReviewCardWidget(
                  date: '23 Mar',
                  reviewerImage: 'https://picsum.photos/200/300?rsdandom',
                  reviewerName: "Neha",
                  rating: 4.5,
                  category: "Cleaning",
                  subCategory: "Home Cleaning",
                  comment:
                      "The service was good, team was professional and came on time. Slight delay in finishing, but overall satisfied.",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
