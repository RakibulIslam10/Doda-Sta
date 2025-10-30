import 'package:doda_work/core/api/model/basic_success_model.dart';
import 'package:doda_work/core/api/services/api.dart';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/routes/routes.dart';

class SettingController extends GetxController {
  RxBool isLoading = false.obs;

  Future<BasicSuccessModel> deleteUserAccount() async {
    return await ApiRequest.delete(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.deleteProfile,
      isLoading: isLoading,
      showSuccessSnackBar: true,
      onSuccess: (result) {
        Get.back();
        AppStorage.clear();
        Get.offAllNamed(Routes.welcomeScreen);
      },
    );
  }
}
