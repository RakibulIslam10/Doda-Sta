import 'package:doda_work/core/api/services/auths.dart';
import 'package:doda_work/views/auth/register/controller/register_controller.dart';

import '../../../../core/utils/basic_import.dart';

class VerifyController extends GetxController {
  final otpController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isLoadingResend = false.obs;

  emailVerifyProcess() async {
    return await AuthService.emailVerifyService(
      isLoading: isLoading,
      email: Get.find<RegisterController>().emailController.text,
      activationCode: otpController.text,
    );
  }

  resendOtpProcess() async {
    return await AuthService.resendOtpService(
      isLoading: isLoadingResend,
      email: Get.find<RegisterController>().emailController.text,
    );
  }
}
