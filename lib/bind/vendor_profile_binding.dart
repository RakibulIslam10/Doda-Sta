import 'package:get/get.dart';
import '../views/vendor_profile/controller/vendor_profile_controller.dart';

class VendorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorProfileController>(() => VendorProfileController());
  }
}
