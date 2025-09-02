import 'package:get/get.dart';
import '../views/update/controller/update_controller.dart';

class UpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateController>(() => UpdateController());
  }
}
