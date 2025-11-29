import 'package:get/get.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api.dart';
import '../../../core/utils/app_storage.dart';
import '../model/review_rating_model.dart'; // New model

class ReviewRatingController extends GetxController {
  // Reactive variables
  var rating = 0.0.obs;
  var totalReviews = 0.obs;
  var isLoading = false.obs;
  var reviewsList = <ReviewResult>[].obs;

  ProviderReviewModel? providerReviewModel;

  /// Fetch provider reviews from API
  Future<void> getProviderReviews() async {
    if (!AppStorage.isProvider) return; // Only for providers

    try {
      isLoading.value = true;

      providerReviewModel = await ApiRequest.get(
        fromJson: ProviderReviewModel.fromJson,
        endPoint: ApiEndPoints.getReviewProvider, // API endpoint for provider reviews
        isLoading: isLoading,
        onSuccess: (result) {
          // Populate reactive variables
          reviewsList.value = result?.data?.result ?? [];
          rating.value = result?.data?.avgRating ?? 0;
          totalReviews.value = result?.data?.meta?.totalReviews ?? 0;
        },
      );
    } catch (e) {
      print("Error fetching provider reviews: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch a single review by reviewId
  Future<ReviewResult?> getReviewById(String reviewId) async {
    try {
      isLoading.value = true;

      final endPoint = '${ApiEndPoints.getReview}?reviewId=$reviewId';

      final result = await ApiRequest.get(
        fromJson: ProviderReviewModel.fromJson,
        endPoint: endPoint,
        isLoading: isLoading,
      );

      if (result?.data?.result != null && result!.data!.result!.isNotEmpty) {
        return result.data!.result!.first;
      }
    } catch (e) {
      print("Error fetching review by ID: $e");
    } finally {
      isLoading.value = false;
    }

    return null;
  }
}
