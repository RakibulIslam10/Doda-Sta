import 'package:doda_work/core/api/services/api.dart';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/profile/model/user_profile_model.dart';
import '../../vendor_profile/model/provider_profile_model.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  UserProfileModel? userProfileModel;
  ProviderProfileModel? providerProfileModel;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  // Load profile based on user type
  Future<void> loadProfile() async {
    if (AppStorage.isVendor == true) {
      await getProviderProfile();
      final providerInfo = providerProfileModel?.data;
    } else {
      await getUserProfile();
      final profileInfo = userProfileModel?.data;
    }
  }

  // Get User Profile API
  Future<void> getUserProfile() async {
    await ApiRequest.get(
      fromJson: UserProfileModel.fromJson,
      endPoint: ApiEndPoints.userProfile,
      isLoading: isLoading,
      onSuccess: (result) {
        userProfileModel = result;
      },
    );
  }

  // Get Provider Profile API
  Future<void> getProviderProfile() async {
    await ApiRequest.get(
      fromJson: ProviderProfileModel.fromJson,
      endPoint: ApiEndPoints.providerProfile,
      isLoading: isLoading,
      onSuccess: (result) {
        providerProfileModel = result;
      },
    );
  }
}
