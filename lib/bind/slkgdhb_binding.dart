import 'package:get/get.dart';
import '../views/slkgdhb/controller/slkgdhb_controller.dart';

class SlkgdhbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SlkgdhbController>(() => SlkgdhbController());
  }
}
