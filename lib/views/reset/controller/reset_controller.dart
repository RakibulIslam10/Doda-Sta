import 'package:get/get.dart';

import '../../../core/utils/basic_import.dart';

class ResetController extends GetxController {
  // TODO: Logic
  // password
  final passConfirmController = TextEditingController();
  final confirmPasswordFocus = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  final isPasswordValid = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;
}
