import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/app_storage.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _checkNavigation();
  }

  void _checkNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    final bool hasValidToken = AppStorage.isLoggedIn && AppStorage.token.isNotEmpty;
    final bool hasSeenOnboarding = AppStorage.seenOnboarding;

    debugPrint("🔍 DEBUG - Token: ${AppStorage.token}");
    debugPrint("🔍 DEBUG - isLoggedIn: ${AppStorage.isLoggedIn}");
    debugPrint("🔍 DEBUG - seenOnboarding: $hasSeenOnboarding");
    debugPrint("🔍 DEBUG - hasValidToken: $hasValidToken");

    if (hasValidToken) {
      // ✅ User is logged in → Go directly to Home
      debugPrint("✅ USER LOGGED IN → HOME");
      Get.offAllNamed(Routes.navigationScreen);
    } else if (!hasSeenOnboarding) {
      debugPrint("🚀 NEW USER → ONBOARDING");
      Get.offAllNamed(Routes.onboardScreen);
    } else {
      debugPrint("🔐 RETURNING USER → LOGIN");
      Get.offAllNamed(Routes.loginScreen);
    }
  }
}
