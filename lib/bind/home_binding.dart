import 'package:get/get.dart';
import '../views/home/controller/home_controller.dart';
import '../views/profile/controller/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // HomeController permanent রাখি, যাতে Profile থেকে back আসার পরও state ঠিক থাকে
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController(), permanent: true);
    }
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController(), permanent: true);
    }


    // ProfileController lazy load
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
