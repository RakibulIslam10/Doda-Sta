import 'package:get/get.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api.dart';
import '../../../core/api/services/api_request.dart';
import '../model/faq_model.dart';

class FaqController extends GetxController {
  /// ============================= GET FAQ Data =====================================

  RxList<FaqData> faqList = <FaqData>[].obs;
  var expandedIndex = (-1).obs;

  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  RxBool isLoading = false.obs;

  Future<FaqModel> fetchFaqs() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.faqGet,
      fromJson: FaqModel.fromJson,
      onSuccess: (result) {
        faqList.assignAll(result.data);
      },
      isLoading: isLoading,
    );
  }
}