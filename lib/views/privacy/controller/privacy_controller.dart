import 'package:doda_work/core/api/end_point/api_end_points.dart';
import 'package:doda_work/core/api/services/api_request.dart';
import 'package:doda_work/views/privacy/model/privacy_model.dart';
import 'package:get/get.dart';

class PrivacyController extends GetxController {

  @override
  void onReady() {
    getPrivacy();
    super.onReady();
  }
  final Rx<PrivacyModel> privacyData = PrivacyModel().obs;
  final RxBool isLoading = false.obs;
  Future<void> getPrivacy() async {
    try{
      isLoading.value = true;
      var response = await ApiClient.get(url: ApiEndPoints.getPrivacy);
      if (response.statusCode == 200) {
        privacyData.value = PrivacyModel.fromJson(response.body);
      }
    }finally{
      isLoading.value = false;
    }

  }
}
