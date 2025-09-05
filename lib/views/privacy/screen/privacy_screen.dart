import 'package:doda_work/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/privacy_controller.dart';

part 'privacy_screen_mobile.dart';

class PrivacyScreen extends GetView<PrivacyController> {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: PrivacyScreenMobile());
  }
}
