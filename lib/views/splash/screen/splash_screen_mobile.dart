part of 'splash_screen.dart';

class SplashScreenMobile extends GetView<SplashController> {
  const SplashScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         color:  Colors.white,
        ),

        child: Image.asset(Assets.logo.aaplogo.path),
      ),
    );
  }
}
