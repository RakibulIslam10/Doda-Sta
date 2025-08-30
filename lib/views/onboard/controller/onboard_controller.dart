import 'package:doda_work/views/onboard/model/onboard_model.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';

class OnboardController extends GetxController {
  // TODO: Logic

  final List<OnboardModel> onboardItemList = [
    OnboardModel(
      image: Assets.dummy.servicesAuth1,
      title: 'Book. Match. Done!',
      subtitle: 'A seamless way to connect clients and local professionals',
    ),
    OnboardModel(
      image: Assets.dummy.servicesAuth1,
      title: 'Book. Match. Done!',
      subtitle: 'A seamless way to connect clients and local professionals',
    ),
    OnboardModel(
      image: Assets.dummy.servicesAuth1,
      title: 'Book. Match. Done!',
      subtitle: 'A seamless way to connect clients and local professionals',
    ),
  ];
}
