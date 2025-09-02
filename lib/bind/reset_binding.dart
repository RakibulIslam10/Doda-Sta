import 'package:get/get.dart';
import '../views/reset/controller/reset_controller.dart';

class ResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetController>(() => ResetController());
  }
}
