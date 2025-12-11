import 'package:doda_work/core/api/services/api.dart';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/profile/model/user_profile_model.dart';
import '../model/provider_model.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  UserProfileModel? userProfileModel;
  ProviderProfileModels? providerProfileModel;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  /// Load profile based on role
  Future<void> loadProfile() async {
    isLoading.value = true;

    if (AppStorage.isProvider) {
      await getProviderProfile();
    } else {
      await getUserProfile();
    }

    isLoading.value = false;
  }

  /// GET USER PROFILE
  Future<void> getUserProfile() async {
    try {
      await ApiRequest.get<UserProfileModel>(
        fromJson: UserProfileModel.fromJson,
        endPoint: ApiEndPoints.userProfile,
        isLoading: isLoading,
        onSuccess: (result) {
          userProfileModel = result;
          print("User Name: ${userProfileModel?.data?.name}");
        },
      );
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

  /// GET PROVIDER PROFILE
  Future<void> getProviderProfile() async {
    try {
      await ApiRequest.get<ProviderProfileModels>(
        fromJson: ProviderProfileModels.fromJson,
        endPoint: ApiEndPoints.providerProfile,
        isLoading: isLoading,
        onSuccess: (result) {
          providerProfileModel = result;
        },
      );
    } catch (e) {
      print("Error fetching provider profile: $e");
    }
  }
}
