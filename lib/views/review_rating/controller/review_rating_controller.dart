import 'package:get/get.dart';

class ReviewRatingController extends GetxController {
  // TODO: Logic
  var rating = 3.5.obs;
  var totalRating = 4.5.obs;
  var reviewText = ''.obs;

  void setRating(double value) {
    rating.value = value;
  }

  void setReviewText(String value) {
    reviewText.value = value;
  }

  void submitReview() {
    // TODO: send to API or local storage
    print("⭐ Rating: ${rating.value}, ✍ Review: ${reviewText.value}");
  }
}
