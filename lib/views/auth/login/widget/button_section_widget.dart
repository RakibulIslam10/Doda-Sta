import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shadify/shadify.dart';

import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/message_helper.dart';
import '../../../../routes/routes.dart';
import '../controller/login_controller.dart';

import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';

import '../../../../routes/routes.dart';
import '../controller/login_controller.dart';

class ButtonSectionWidget extends GetView<LoginController> {
  const ButtonSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// EMAIL SIGN-IN BUTTON
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

        /// SIGN-UP NAVIGATION
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextWidget(
              'Don\'t have an account?',
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
        Space.height.v5,

        /// GOOGLE SIGN-IN
        SocialLoginButton(
          iconPath: Assets.logo.google,
          title: 'Sign in with Google',
          radius: Dimensions.radius * 3,
          onTap: () => controller.signInWithGoogle(),
        ),

        /// APPLE SIGN-IN
        SocialLoginButton(
          iconPath: Assets.logo.page1,
          title: 'Sign in with Apple',
          radius: Dimensions.radius * 3,
          onTap: () => controller.signInWithApple(),
        ),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final double? radius;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.iconPath,
    required this.title,
    this.radius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: Dimensions.heightSize * 0.5),
        height: Dimensions.buttonHeight * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Dimensions.radius),
          border: Border.all(color: CustomColors.primary, width: 1.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            TextWidget(
              title,
              padding: Dimensions.widthSize.edgeLeft,
            ),
          ],
        ),
      ),
    );
  }
}