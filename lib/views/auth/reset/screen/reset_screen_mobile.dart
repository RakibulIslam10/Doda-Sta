part of 'reset_screen.dart';

class ResetScreenMobile extends GetView<ResetController> {
  const ResetScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Reset Password'),

      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              hintText: "Enter your password",
              label: "Password",
              isPassword: true,
              controller: controller.passwordController,
              focusNode: controller.passwordFocus,
              nextFocusNode: controller.confirmPasswordFocus,
            ),

            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              hintText: "Confirm your password",
              label: "Confirm Password",
              isPassword: true,
              controller: controller.passConfirmController,
              focusNode: controller.confirmPasswordFocus,
              nextFocusNode: null,
              confirmWith:
                  controller.passwordController, // only checks matching
            ),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,
            PrimaryButtonWidget(
              title: "Reset Password",
              onPressed: () {
                Get.offAllNamed(Routes.homeScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
