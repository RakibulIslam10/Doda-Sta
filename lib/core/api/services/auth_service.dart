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
      onSuccess: (result) => Get.toNamed(Routes.verificationScreen),
    );
  }

  /// =============================================== ✅ Email Verify  ================================================== ///

  /// =============================================== ✅ Resend Verification ================================================== ///
}
