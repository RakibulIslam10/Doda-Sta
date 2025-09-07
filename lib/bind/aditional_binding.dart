import 'package:get/get.dart';
import '../views/aditional/controller/aditional_controller.dart';

class AditionalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AditionalController>(() => AditionalController());
  }
}
