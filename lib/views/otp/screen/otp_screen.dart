import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/views/auth/login/controller/login_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/utils/basic_import.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/timer_widget.dart';
import '../../auth/register/controller/register_controller.dart';
import '../controller/otp_controller.dart';

part 'otp_screen_mobile.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: OtpScreenMobile());
  }
}
