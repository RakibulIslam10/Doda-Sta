import '../../../core/api/services/auth_service.dart';
import '../../../core/utils/basic_import.dart';
import '../../auth/register/controller/register_controller.dart';
class OtpController extends GetxController {
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
