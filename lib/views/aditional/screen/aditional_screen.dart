import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../widgets/custom_drop_down_widget.dart';
import '../../../widgets/time_picker_widget.dart';
import '../controller/aditional_controller.dart';
part 'aditional_screen_mobile.dart';

class AditionalScreen extends GetView<AditionalController> {
  const AditionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: AditionalScreenMobile());
  }
}
