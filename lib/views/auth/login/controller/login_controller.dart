import 'package:doda_work/core/api/services/api.dart';
import 'package:doda_work/core/api/services/auth_service.dart';
import 'package:doda_work/core/api/services/auths.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/auth/login/model/login_model.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // email
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final isEmailValid = false.obs;

  // password
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  final isPasswordValid = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.text = 'rakib10.devs@gmail.com';
    passwordController.text = '123456';
  }

  RxBool isLoading = true.obs;

  // login APi
  loginProcess() async {
    return await AuthService.loginService(
      isLoading: isLoading,
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
