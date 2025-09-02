import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bind/chat_binding.dart';
import '../bind/forgot_binding.dart';
import '../bind/home_binding.dart';
import '../bind/login_binding.dart';
import '../bind/navigation_binding.dart';
import '../bind/onboard_binding.dart';
import '../bind/profile_binding.dart';
import '../bind/register_binding.dart';
import '../bind/request_binding.dart';
import '../bind/reset_binding.dart';
import '../bind/splash_binding.dart';
import '../bind/verification_binding.dart';
import '../bind/verify_binding.dart';
import '../bind/welcome_binding.dart';
import '../views/auth/forgot/screen/forgot_screen.dart';
import '../views/auth/login/screen/login_screen.dart';
import '../views/auth/register/screen/register_screen.dart';
import '../views/auth/reset/screen/reset_screen.dart';
import '../views/auth/verification/screen/verification_screen.dart';
import '../views/auth/verify/screen/verify_screen.dart';
import '../views/chat/screen/chat_screen.dart';
import '../views/home/screen/home_screen.dart';
import '../views/navigation/screen/navigation_screen.dart';
import '../views/onboard/screen/onboard_screen.dart';
import '../views/profile/screen/profile_screen.dart';
import '../views/request/screen/request_screen.dart';
import '../views/splash/screen/splash_screen.dart';
import '../views/welcome/screen/welcome_screen.dart';

part 'pages.dart';

class Routes {
  static var list = RoutePageList.list;
static const profileScreen = '/profileScreen';
static const chatScreen = '/chatScreen';
static const requestScreen = '/requestScreen';
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
