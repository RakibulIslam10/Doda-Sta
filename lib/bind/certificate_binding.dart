import 'package:get/get.dart';
import '../views/certificate/controller/certificate_controller.dart';

class CertificateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CertificateController>(() => CertificateController());
  }
}
