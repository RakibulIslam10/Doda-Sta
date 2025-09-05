import 'package:get/get.dart';
import '../views/document/controller/document_controller.dart';

class DocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentController>(() => DocumentController());
  }
}
