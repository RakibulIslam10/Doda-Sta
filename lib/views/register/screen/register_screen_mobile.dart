part of 'register_screen.dart';

class RegisterScreenMobile extends GetView<RegisterController> {
  const RegisterScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            TextWidget(
              'Sign Up',
              fontSize: Dimensions.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            TextWidget(
              "Let's get you set up and ready to go.",
              color: CustomColors.primary,
              fontWeight: FontWeight.w500,
            ),
            Space.height.v20,
            PrimaryInputFieldWidget(
              controller: controller.nameController,
              hintText: 'Enter your preferred name',
              label: 'Preferred Name',
              nextFocusNode: controller.emailFocus,
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              label: "Email",
              isEmail: true,
              controller: controller.emailController,
              focusNode: controller.emailFocus,
              nextFocusNode: controller.passwordFocus,
              hintText: "Enter your email",
            ),
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
            Space.height.v20,
            Row(
              crossAxisAlignment: crossStart,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(value: true, onChanged: (value) {}),
                ),
                Expanded(
                  child: TextWidget(
                    padding: EdgeInsetsGeometry.only(
                      left: Dimensions.widthSize,
                    ),
                    "I have read and agree to dodawork's Terms and Conditions and Policy.",
                    maxLines: 2,
                    fontSize: Dimensions.titleSmall * 0.9,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Space.height.v20,
            PrimaryButtonWidget(title: "Next", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
