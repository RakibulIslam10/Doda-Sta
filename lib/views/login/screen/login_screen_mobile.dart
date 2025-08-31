part of 'login_screen.dart';

class LoginScreenMobile extends GetView<LoginController> {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            TextWidget(
              'Welcome Back',
              fontSize: Dimensions.titleLarge * 1.2,
              fontWeight: FontWeight.bold,
            ),

            SvgPicture.asset(
              Assets.dummy.tabletLoginAmico1,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
            ),

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
              nextFocusNode: null,
            ),
          ],
        ),
      ),
    );
  }
}
