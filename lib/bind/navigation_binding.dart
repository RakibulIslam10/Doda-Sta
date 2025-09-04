import 'package:doda_work/views/home/controller/home_controller.dart';
import 'package:get/get.dart';
import '../views/navigation/controller/navigation_controller.dart';
import '../views/request/controller/request_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    // NavigationController bind
    Get.lazyPut<NavigationController>(() => NavigationController());

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<RequestController>(() => RequestController());
  }
}
