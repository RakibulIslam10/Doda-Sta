import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/core/utils/space.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../gen/assets.gen.dart';
import '../controller/onboard_controller.dart';

part 'onboard_screen_mobile.dart';

class OnboardScreen extends GetView<OnboardController> {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: OnboardScreenMobile());
  }
}
