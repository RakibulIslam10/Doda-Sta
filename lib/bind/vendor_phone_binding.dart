import 'package:get/get.dart';
import '../views/vendor_phone/controller/vendor_phone_controller.dart';

class VendorPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorPhoneController>(() => VendorPhoneController());
  }
}
