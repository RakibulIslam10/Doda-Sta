import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/aditional_controller.dart';

part 'aditional_screen_mobile.dart';

class AditionalScreen extends GetView<AditionalController> {
  const AditionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: AditionalScreenMobile());
  }
}
