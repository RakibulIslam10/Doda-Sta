import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/review_rating/screen/review_rating_screen_mobile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controller/review_rating_controller.dart';

part '../widget/review_card_widget.dart';
part '../widget/top_text_widget.dart';

class ReviewRatingScreen extends GetView<ReviewRatingController> {
  const ReviewRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ReviewRatingScreenMobile());
  }
}
