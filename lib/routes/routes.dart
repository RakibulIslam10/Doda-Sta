import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bind/login_binding.dart';
import '../bind/navigation_binding.dart';
import '../bind/onboard_binding.dart';
import '../bind/splash_binding.dart';
import '../views/login/screen/login_screen.dart';
import '../views/navigation/screen/navigation_screen.dart';
import '../views/onboard/screen/onboard_screen.dart';
import '../views/splash/screen/splash_screen.dart';

part 'pages.dart';

class Routes {
  static var list = RoutePageList.list;
  static const navigationScreen = '/navigationScreen';
  static const loginScreen = '/loginScreen';
  static const onboardScreen = '/onboardScreen';
  static const splashScreen = '/splashScreen';
}
