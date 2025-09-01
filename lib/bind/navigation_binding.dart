import 'package:doda_work/views/home/controller/home_controller.dart';
import 'package:get/get.dart';
import '../views/navigation/controller/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    // NavigationController bind
    Get.lazyPut<NavigationController>(() => NavigationController());

    // HomeController bind
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
