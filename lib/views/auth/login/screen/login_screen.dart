import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../controller/login_controller.dart';
import '../widget/button_section_widget.dart';
import '../widget/field_section_widget.dart';

part 'login_screen_mobile.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: LoginScreenMobile());
  }
}
