import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/views/vendor_profile/screen/vendor_profile_screen_mobile.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/custom_drop_down_widget.dart';
import 'package:doda_work/widgets/loading_widget.dart';
import 'package:map_location_picker/map_location_picker.dart';
import '../../request/widget/category_widget.dart';
import '../controller/vendor_profile_controller.dart';


class VendorProfileScreen extends GetView<VendorProfileController> {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: VendorProfileScreenMobile());
  }
}
