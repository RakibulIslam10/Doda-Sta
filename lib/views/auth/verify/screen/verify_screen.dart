import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../widgets/auth_app_bar.dart';
import '../../../../widgets/timer_widget.dart';
import '../controller/verify_controller.dart';

part 'verify_screen_mobile.dart';

class VerifyScreen extends GetView<VerifyController> {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: VerifyScreenMobile());
  }
}
