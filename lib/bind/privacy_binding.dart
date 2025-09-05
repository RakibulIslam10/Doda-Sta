import 'package:get/get.dart';
import '../views/privacy/controller/privacy_controller.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyController>(() => PrivacyController());
  }
}
