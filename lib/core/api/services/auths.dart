import 'package:doda_work/core/api/model/basic_success_model.dart';
import 'package:doda_work/core/utils/message_helper.dart';
import '../../../routes/routes.dart';
import '../../../views/auth/login/model/login_model.dart';
import '../../../views/auth/register/model/provider_otp_verify_model.dart';
import '../../../views/vendor_profile/screen/vendor_profile_screen_mobile.dart';
import '../../utils/app_storage.dart';
import '../../utils/basic_import.dart';
import 'api.dart';
import 'package:doda_work/widgets/success_dialog.dart';

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
        final role = result.data.user.authId.role.toUpperCase();
        final id = result.data.user.id;

        // ✅ Selected role এর সাথে actual role মিলাও
        final selectedRole = AppStorage.users
            ?.toUpperCase(); // 'USER' or 'PROVIDER'

        if (selectedRole != null && role != selectedRole) {
          MessageHelper.showError(
            "This account is registered as a ${role == 'PROVIDER' ? 'Service Provider' : 'Client'}.\nPlease use the correct login option.",
          );
          return; // ❌ Navigate করবে না
        }

        AppStorage.save(uId: id);
        AppStorage.save(token: result.data.accessToken, isLoggedIn: true);
        AppStorage.saveRole(role);
        AppStorage.isVendor = role == "PROVIDER";

        if (role == "PROVIDER") {
          Get.offAllNamed(Routes.navigationScreen);
        } else if (role == "USER") {
          Get.offAllNamed(Routes.navigationScreen);
        } else {
          MessageHelper.showError("Please Select Your Role.\nThank you");
        }
      },
    );
  }

  /// =============================================== ✅ Register  ================================================== ///

  static Future<BasicSuccessModel> registerService({
    required RxBool isLoading,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
    required String confirmPassword,
  }) async {
    Map<String, dynamic> inputBody = {
      'email': email,
      'role': role,
      'phoneNumber': phone,
      'name': name,
      'password': password,
      'confirmPassword': confirmPassword,
    };

    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.register,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) {
        Get.toNamed(Routes.verifyScreen);
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

  /// =============================================== ✅ Email Verify  ================================================== ///

  static Future<ProviderOtpVerify> emailVerifyService({
    required RxBool isLoading,
    required String email,
    required String activationCode,
  }) async {
    Map<String, dynamic> inputBody = {
      'activationCode': activationCode,
      'email': email,
    };
    return await ApiRequest.post(
      fromJson: ProviderOtpVerify.fromJson,
      endPoint: ApiEndPoints.verifyEmail,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) {
        if (AppStorage.users == "PROVIDER") {
          Get.toNamed(Routes.aditionalScreen);
        } else {
          SuccessDialog.show(
            title: "Registration Successful",
            subtitle:
                "Your account has been created successfully. Please login to continue.",
            onTap: () => Get.offAllNamed(Routes.loginScreen),
          );
        }

        // AppStorage.isVendor == true
        //     ? Get.toNamed(Routes.aditionalScreen)
        //     : Get.offAllNamed(Routes.loginScreen);

        AppStorage.save(token: result.data.accessToken);
      },
    );
  }

  /// =============================================== ✅ Otp Verify  ================================================== ///

  static Future<BasicSuccessModel> otpVerifyService({
    required RxBool isLoading,
    required String email,
    required String activationCode,
  }) async {
    Map<String, dynamic> inputBody = {'code': activationCode, 'email': email};
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.forgotOtpVerify,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) {
        // if (AppStorage.users == "PROVIDER") {
        //   Get.toNamed(Routes.aditionalScreen);
        // } else {
        //   SuccessDialog.show(
        //     title: "Registration Successful",
        //     subtitle: "Your account has been created successfully. Please login to continue.",
        //     onTap: () => Get.offAllNamed(Routes.loginScreen),
        //   );
        // }
        //
        // // AppStorage.isVendor == true
        // //     ? Get.toNamed(Routes.aditionalScreen)
        // //     : Get.offAllNamed(Routes.loginScreen);
        //
        // AppStorage.save(token: result.data.accessToken);

        Get.toNamed(Routes.resetScreen);
      },
    );
  }

  /// =============================================== ✅ Resend Verification ================================================== ///

  static Future<BasicSuccessModel> resendOtpService({
    required RxBool isLoading,
    required String email,
  }) async {
    Map<String, dynamic> inputBody = {'email': email};
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.resendOtpCode,
      isLoading: isLoading,
      body: inputBody,
      showSuccessSnackBar: true,
      onSuccess: (result) {},
    );
  }

  /// =============================================== ✅ Change Password ================================================== ///

  static Future<BasicSuccessModel> changePasswordService({
    required RxBool isLoading,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Map<String, dynamic> inputBody = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
    return await ApiRequest.patch(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.changePassword,
      isLoading: isLoading,
      body: inputBody,
      showSuccessSnackBar: true,
      onSuccess: (result) {
        MessageHelper.showSuccess("Change Password Success");
        Get.back();
        Get.toNamed(Routes.loginScreen);
      },
    );
  }

  static Future<BasicSuccessModel> resetPasswordService({
    required RxBool isLoading,
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Map<String, dynamic> inputBody = {
      'email': email,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.resetPassword,
      isLoading: isLoading,
      body: inputBody,

      showSuccessSnackBar: true,
      onSuccess: (result) {
        MessageHelper.showSuccess("Password reset was successful");
        Get.back();
        Get.toNamed(Routes.loginScreen);
      },
    );
  }
}
