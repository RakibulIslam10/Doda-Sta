import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../gen/assets.gen.dart';
import '../controller/splash_controller.dart';

part 'splash_screen_mobile.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: SplashScreenMobile());
  }
}
