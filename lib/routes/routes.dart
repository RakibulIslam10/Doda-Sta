import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bind/forgot_binding.dart';
import '../bind/home_binding.dart';
import '../bind/login_binding.dart';
import '../bind/navigation_binding.dart';
import '../bind/onboard_binding.dart';
import '../bind/register_binding.dart';
import '../bind/reset_binding.dart';
import '../bind/splash_binding.dart';
import '../bind/verification_binding.dart';
import '../bind/verify_binding.dart';
import '../bind/welcome_binding.dart';
import '../views/forgot/screen/forgot_screen.dart';
import '../views/home/screen/home_screen.dart';
import '../views/login/screen/login_screen.dart';
import '../views/navigation/screen/navigation_screen.dart';
import '../views/onboard/screen/onboard_screen.dart';
import '../views/register/screen/register_screen.dart';
import '../views/reset/screen/reset_screen.dart';
import '../views/splash/screen/splash_screen.dart';
import '../views/verification/screen/verification_screen.dart';
import '../views/verify/screen/verify_screen.dart';
import '../views/welcome/screen/welcome_screen.dart';

part 'pages.dart';

class Routes {
  static var list = RoutePageList.list;
static const verifyScreen = '/verifyScreen';
static const resetScreen = '/resetScreen';
static const verificationScreen = '/verificationScreen';
static const forgotScreen = '/forgotScreen';
static const homeScreen = '/homeScreen';
  static const navigationScreen = '/navigationScreen';
  static const registerScreen = '/registerScreen';
  static const welcomeScreen = '/welcomeScreen';
  static const loginScreen = '/loginScreen';
  static const onboardScreen = '/onboardScreen';
  static const splashScreen = '/splashScreen';
}
