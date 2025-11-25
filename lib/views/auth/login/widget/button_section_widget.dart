import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shadify/shadify.dart';
import '../../../../core/api/services/auths.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/message_helper.dart';
import '../../../../routes/routes.dart';
import '../../../home/screen/home_screen.dart';
import '../../../home/screen/home_screen_mobile.dart';
import '../../../navigation/screen/navigation_screen.dart';
import '../../../onboard/screen/onboard_screen.dart';

import '../controller/login_controller.dart';

class ButtonSectionWidget extends GetView<LoginController> {

    ButtonSectionWidget({super.key});


   bool loading = false;

   Future<void> handleLogin() async {


     UserCredential? user = await LoginController.signInWithApple();


     if (user != null) {

       MessageHelper.showSuccess("success");

     } else {
       MessageHelper.showSuccess("Not Success");

     }
   }


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Obx(
          () => PrimaryButtonWidget(
            title: 'Sign in',
            isLoading: controller.isLoading.value,
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.loginProcess();
              }
            },
          ),
        ),
        Space.height.v10,

        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TextWidget(
              padding: Dimensions.widthSize.edgeLeft,
              'Don’t have an account?',
              color: CustomColors.secondaryDarkText,
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.titleMedium * 0.96,
            ),
            TextWidget(
              padding: Dimensions.widthSize.edgeLeft * 0.4,
              'Sign Up',
              onTap: () => Get.toNamed(Routes.registerScreen),
              color: CustomColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.titleMedium * 0.96,
            ),
          ],
        ),
        TextWidget(
          'Or',
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
        ),

        GestureDetector(
         // onTap: () => googleLoginController.signInWithGoogle(context),
          onTap: () async {
            try {
              final user = await controller.signInWithGoogle(context); // now returns User?
              String? token = await user?.getIdToken();
              print("GetToken: $token");

              if (user != null) {
                AppStorage.token;
                Get.offAllNamed(Routes.navigationScreen);
                MessageHelper.showSuccess("Sign-In successful!");
                // Success logic
              } else {
                MessageHelper.showError("Sign-In failed. Please try again.");
              }
            }catch (e) {
              MessageHelper.showError("Error: $e"); // Provide a meaningful error message
            }
          },
          child: Container(
            margin: Dimensions.verticalSize.edgeVertical * 0.5,
            height: Dimensions.buttonHeight * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              border: Border.all(color: CustomColors.primary, width: 1.4),
            ),

            child: Row(
              mainAxisAlignment: mainCenter,
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
        Container(
          margin: Dimensions.heightSize.edgeTop * 0.2,
          height: Dimensions.buttonHeight * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 3),
            border: Border.all(color: CustomColors.primary, width: 1.4),
          ),
          child: Row(
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(Assets.logo.page1),
              TextWidget(
                'Sign in with Apple',
                padding: Dimensions.widthSize.edgeLeft,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
