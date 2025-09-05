import 'package:get/get.dart';

import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 1), () {
      Get.offAllNamed(Routes.onboardScreen);
    });
  }
}
