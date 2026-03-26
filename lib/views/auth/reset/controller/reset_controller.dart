import 'package:doda_work/core/api/model/basic_success_model.dart';
import 'package:doda_work/views/auth/forgot/controller/forgot_controller.dart';

import '../../../../core/api/services/auths.dart';
import '../../../../core/utils/basic_import.dart';

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

  RxBool isLoading = false.obs;

  Future<BasicSuccessModel> resetPasswordService() async {
    return await AuthService.resetPasswordService(
      isLoading: isLoading,
      confirmPassword: passConfirmController.text,
      email: Get.find<ForgotController>().emailController.text,
      newPassword: passwordController.text,
    );
  }
}
