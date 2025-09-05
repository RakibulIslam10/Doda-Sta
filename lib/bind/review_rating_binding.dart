import 'package:get/get.dart';
import '../views/review_rating/controller/review_rating_controller.dart';

class ReviewRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewRatingController>(() => ReviewRatingController());
  }
}
