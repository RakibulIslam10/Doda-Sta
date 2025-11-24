import 'package:get/get.dart';

import '../../../core/utils/app_storage.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 5), () {
      if (AppStorage.isLoggedIn) {

        Get.toNamed(Routes.navigationScreen);
      } else {
        Get.toNamed(Routes.welcomeScreen);
      }
    });
  }
}
