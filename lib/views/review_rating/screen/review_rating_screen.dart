import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/review_rating_controller.dart';

part 'review_rating_screen_mobile.dart';
part '../widget/review_card_widget.dart';
part '../widget/top_text_widget.dart';

class ReviewRatingScreen extends GetView<ReviewRatingController> {
  const ReviewRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ReviewRatingScreenMobile());
  }
}
