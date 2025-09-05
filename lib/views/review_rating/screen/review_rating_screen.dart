import 'package:doda_work/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/review_rating_controller.dart';

part 'review_rating_screen_mobile.dart';

class ReviewRatingScreen extends GetView<ReviewRatingController> {
  const ReviewRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ReviewRatingScreenMobile());
  }
}
