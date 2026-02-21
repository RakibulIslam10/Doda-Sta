import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/vendor_profile/screen/vendor_profile_screen_mobile.dart';

import '../controller/vendor_profile_controller.dart';

class VendorProfileScreen extends GetView<VendorProfileController> {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: VendorProfileScreenMobile());
  }
}
