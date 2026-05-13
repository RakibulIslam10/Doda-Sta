import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/views/auth/register/controller/register_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../widgets/auth_app_bar.dart';
import '../../../../widgets/timer_widget.dart';
import '../controller/verification_controller.dart';

part 'verification_screen_mobile.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: VerificationScreenMobile());
  }
}
