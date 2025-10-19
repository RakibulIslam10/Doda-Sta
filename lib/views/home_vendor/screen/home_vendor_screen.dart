import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../../home/screen/home_screen.dart';
import '../controller/home_vendor_controller.dart';

part 'home_vendor_screen_mobile.dart';
part '../widget/vendor_status_card_widget.dart';
part '../widget/tab_bar_view_status_widget.dart';

class HomeVendorScreen extends GetView<HomeVendorController> {
  const HomeVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: HomeVendorScreenMobile());
  }
}
