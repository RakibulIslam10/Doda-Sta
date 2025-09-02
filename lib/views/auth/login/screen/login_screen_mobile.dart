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
              height: MediaQuery.of(context).size.height * 0.26,
            ),

            FieldSectionWidget(),
            ButtonSectionWidget(),

          ],
        ),
      ),
    );
  }
}
