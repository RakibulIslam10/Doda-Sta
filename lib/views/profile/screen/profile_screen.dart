import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import '../../../core/utils/basic_import.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../controller/profile_controller.dart';

part 'profile_screen_mobile.dart';
part '../widget/profile_top_header_widget.dart';
part '../widget/profile_card_section_widget.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ProfileScreenMobile());
  }
}
