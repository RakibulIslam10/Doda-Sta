
import 'package:country_picker/country_picker.dart';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import '../../../core/utils/basic_import.dart';
import '../../../widgets/auth_app_bar.dart';
import '../controller/welcome_controller.dart';

part 'welcome_screen_mobile.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: WelcomeScreenMobile());
  }
}
