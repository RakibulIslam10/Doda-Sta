import 'package:get/get.dart';
import '../views/licence/controller/licence_controller.dart';

class LicenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LicenceController>(() => LicenceController());
  }
}
