import '../../../core/utils/basic_import.dart';
import '../../../core/utils/extensions.dart';
import '../../../routes/routes.dart';
import '../controller/congratulations_controller.dart';
part 'congratulations_screen_mobile.dart';

class CongratulationsScreen extends GetView<CongratulationsController> {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: CongratulationsScreenMobile());
  }
}
