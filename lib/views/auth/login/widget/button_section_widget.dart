import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shadify/shadify.dart';

import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/message_helper.dart';
import '../../../../routes/routes.dart';
import '../controller/login_controller.dart';

class ButtonSectionWidget extends GetView<LoginController> {
  ButtonSectionWidget({super.key});

  /// ----------------------
  /// 🔥 APPLE LOGIN HANDLER
  /// ----------------------
  Future<void> handleAppleLogin() async {
    try {
      final user = await LoginController.signInWithApple();

      if (user != null) {
        await AppStorage.save(token: user.credential!.accessToken.toString(),isLoggedIn: true);
        MessageHelper.showSuccess("Apple Sign-in Successful");
        Get.offAllNamed(Routes.navigationScreen);
      } else {
        MessageHelper.showError("Apple Sign-In only for iOS/macOS.");
      }
    } catch (e) {
      MessageHelper.showError("Error: $e");
    }
  }

  /// ----------------------
  /// 🔥 GOOGLE LOGIN HANDLER
  /// ----------------------
  Future<void> handleGoogleLogin(BuildContext context) async {
    try {
      final user = await controller.signInWithGoogle(context);

      if (user == null) {
        MessageHelper.showError("Google Sign-in Failed. Try again.");
        return;
      }

      final token = await user.getIdToken();
      if (kDebugMode) {
        print("TOKEN: $token");
      }
      await AppStorage.save(token: token,isLoggedIn: true);
      MessageHelper.showSuccess("Sign-In Successful!");
      Get.offAllNamed(Routes.navigationScreen);

    } catch (e) {
      MessageHelper.showError("Google error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ----------------------
        /// 🔥 EMAIL SIGN-IN BUTTON
        /// ----------------------
        Obx(
              () => PrimaryButtonWidget(
            title: 'Sign in',
            isLoading: controller.isLoading.value,
            onPressed: () {
              if (controller.formKey.currentState?.validate() ?? false) {
                controller.loginProcess();
              }
            },
          ),
        ),

        Space.height.v10,

        /// ----------------------
        /// 🔥 SIGN-UP NAVIGATION
        /// ----------------------
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextWidget(
              'Don’t have an account?',
              fontSize: Dimensions.titleMedium * 0.96,
              color: CustomColors.secondaryDarkText,
            ),
            TextWidget(
              'Sign Up',
              onTap: () => Get.toNamed(Routes.registerScreen),
              padding: Dimensions.widthSize.edgeLeft * 0.5,
              color: CustomColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.titleMedium * 0.96,
            ),
          ],
        ),

        Space.height.v5,
        TextWidget('Or', textAlign: TextAlign.center),

        /// ----------------------
        /// 🔥 GOOGLE SIGN-IN
        /// ----------------------
        GestureDetector(
          onTap: () => handleGoogleLogin(context),
          child: Container(
            margin: Dimensions.verticalSize.edgeVertical * 0.5,
            height: Dimensions.buttonHeight * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              border: Border.all(color: CustomColors.primary, width: 1.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.logo.google),
                TextWidget(
                  'Sign in with Google',
                  padding: Dimensions.widthSize.edgeLeft,
                ),
              ],
            ),
          ),
        ),

        /// ----------------------
        /// 🔥 APPLE SIGN-IN
        /// ----------------------
        GestureDetector(
          onTap: handleAppleLogin,
          child: Container(
            margin: Dimensions.heightSize.edgeTop * 0.2,
            height: Dimensions.buttonHeight * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              border: Border.all(color: CustomColors.primary, width: 1.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.logo.page1),
                TextWidget(
                  'Sign in with Apple',
                  padding: Dimensions.widthSize.edgeLeft,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
