import 'package:doda_work/core/api/services/auth_service.dart';

import '../../../../core/utils/basic_import.dart';

class ForgotController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // email
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final isEmailValid = false.obs;

  RxBool isLoading = false.obs;

  forgotPasswordProcess() async {
    await AuthService.forgotPasswordService(
      isLoading: isLoading,
      email: emailController.text,
    );
  }
}
