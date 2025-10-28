import 'package:doda_work/views/auth/forgot/controller/forgot_controller.dart';

import '../../../../core/api/services/auths.dart';
import '../../../../core/utils/basic_import.dart';

class VerificationController extends GetxController {
  final otpController = TextEditingController();
  RxBool isLoading = false.obs;

  emailVerifyProcess() async {
    return await AuthService.emailVerifyService(
      activationCode: otpController.text,
      isLoading: isLoading,
      email: Get.find<ForgotController>().emailController.text,
    );
  }
}
