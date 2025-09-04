part of 'routes.dart';

class RoutePageList {
  static var list = [
    //Page Route List
GetPage(
    name: Routes.inboxScreen,
    page: () => const InboxScreen(),
    binding: InboxBinding(),
  ),
    GetPage(
      name: Routes.categoryPreviewScreen,
      page: () => const CategoryPreviewScreen(),
      binding: CategoryPreviewBinding(),
    ),
    GetPage(
      name: Routes.allCategoryScreen,
      page: () => const AllCategoryScreen(),
      binding: AllCategoryBinding(),
    ),
    GetPage(
      name: Routes.summaryScreen,
      page: () => const SummaryScreen(),
      binding: SummaryBinding(),
    ),
    GetPage(
      name: Routes.updateScreen,
      page: () => const UpdateScreen(),
      binding: UpdateBinding(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.chatScreen,
      page: () => const ChatScreen(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.requestScreen,
      page: () => const RequestScreen(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: Routes.verifyScreen,
      page: () => const VerifyScreen(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: Routes.resetScreen,
      page: () => const ResetScreen(),
      binding: ResetBinding(),
    ),
    GetPage(
      name: Routes.verificationScreen,
      page: () => const VerificationScreen(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: Routes.forgotScreen,
      page: () => const ForgotScreen(),
      binding: ForgotBinding(),
    ),

    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.navigationScreen,
      page: () => const NavigationScreen(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: Routes.registerScreen,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.navigationScreen,
      page: () => const NavigationScreen(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.onboardScreen,
      page: () => const OnboardScreen(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
  ];
}
