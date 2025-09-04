import 'package:get/get.dart';
import '../views/summary/controller/summary_controller.dart';

class SummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummaryController>(() => SummaryController());
  }
}
