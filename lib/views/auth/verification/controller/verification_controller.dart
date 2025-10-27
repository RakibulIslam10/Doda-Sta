import 'package:doda_work/core/api/services/auth_service.dart';
import 'package:doda_work/views/auth/register/controller/register_controller.dart';

import '../../../../core/utils/basic_import.dart';

class VerificationController extends GetxController {
  final otpController = TextEditingController();
  RxBool isLoading = false.obs;

  // emailVerifyProcess() async {
  //   return await AuthService.emailVerifyService(
  //     isLoading: isLoading,
  //     email: Get.find<RegisterController>().emailController.text,
  //     code: otpController.text,
  //   );
  // }
}
