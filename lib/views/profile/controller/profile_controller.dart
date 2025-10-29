import 'package:doda_work/core/api/services/api.dart';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/profile/model/user_profile_model.dart';

import '../../vendor_profile/model/provider_profile_model.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    AppStorage.isVendor == true ? getProviderProfile() : getUserProfile();
  }

  // Profile get api
  RxBool isLoading = false.obs;
  late UserProfileModel userProfileModel;

  Future<UserProfileModel> getUserProfile() async {
    return await ApiRequest.get(
      fromJson: UserProfileModel.fromJson,
      endPoint: ApiEndPoints.userProfile,
      isLoading: isLoading,
      onSuccess: (result) {
        userProfileModel = result;
      },
    );
  }

  // Profile get api
  late ProviderProfileModel providerProfileModel;

  Future<ProviderProfileModel> getProviderProfile() async {
    return await ApiRequest.get(
      fromJson: ProviderProfileModel.fromJson,
      endPoint: ApiEndPoints.userProfile,
      isLoading: isLoading,
      onSuccess: (result) {
        providerProfileModel = result;
      },
    );
  }
}
