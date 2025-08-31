import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/views/onboard/model/onboard_model.dart';

class OnboardController extends GetxController {
  final pageController = PageController();
  var currentIndex = 0.obs;

  final textController = TextEditingController();

  final List<OnboardModel> onboardItemList = [
    OnboardModel(
      image: Assets.dummy.servicesAuth1,
      title: 'Book. Match. Done!',
      subtitle: 'A seamless way to connect clients and local professionals',
    ),
    OnboardModel(
      image: Assets.dummy.carWashRafiki1,
      title: 'Trusted. Verified. Nearby!',
      subtitle: 'Skilled professionals are just a few clicks away.',
    ),
    OnboardModel(
      image: Assets.dummy.frame,
      title: 'Stay in touch while we fix it.',
      subtitle: 'Built-in chat, verified users, and secure profiles — your happiness matters most.',
    ),
  ];

  void next() {
    if (currentIndex.value < onboardItemList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed(Routes.loginScreen);
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}
