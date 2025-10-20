import 'package:doda_work/core/api/model/basic_success_model.dart';
import '../../../routes/routes.dart';
import '../../../views/auth/login/model/login_model.dart';
import '../../utils/app_storage.dart';
import '../../utils/basic_import.dart';

class AuthService {
  /// =============================================== ✅ Login  ================================================== ///

  static Future<LoginModel> loginService({
    required RxBool isLoading,
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> inputBody = {'email': email, 'password': password};
    return await ApiRequest.post(
      fromJson: LoginModel.fromJson,
      endPoint: ApiEndPoints.login,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) {
        AppStorage.save(token: result.data.accessToken, isLoggedIn: true);
        Get.offAllNamed(Routes.navigationScreen);
      },
    );
  }

  /// =============================================== ✅ Register  ================================================== ///
  ///
  static Future<BasicSuccessModel> registerService({
    required RxBool isLoading,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String role,
  }) async {
    Map<String, dynamic> inputBody = {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phoneNumber': phoneNumber,
      'role': role,
    };
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.register,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) => Get.toNamed(Routes.verifyScreen),
    );
  }

  /// =============================================== ✅ Email Verify  ================================================== ///

  static Future<BasicSuccessModel> emailVerifyService({
    required RxBool isLoading,
    required String email,
    required String code,
  }) async {
    Map<String, dynamic> inputBody = {'email': email, 'activationCode': code};
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.verifyEmail,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) {
        AppStorage.isVendor == true
            ? Get.toNamed(Routes.aditionalScreen)
            : Get.toNamed(Routes.resetScreen);
      },
    );
  }

  /// =============================================== ✅ Forget Password ================================================== ///

  static Future<BasicSuccessModel> forgotPasswordService({
    required RxBool isLoading,
    required String email,
  }) async {
    Map<String, dynamic> inputBody = {'email': email};
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.forgotPassword,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) => Get.toNamed(Routes.otpScreen),
    );
  }

  /// =============================================== ✅ Resend Verification ================================================== ///
}
