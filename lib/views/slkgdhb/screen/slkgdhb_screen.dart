import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/layout.dart';
import '../controller/slkgdhb_controller.dart';

part 'slkgdhb_screen_mobile.dart';

class SlkgdhbScreen extends GetView<SlkgdhbController> {
  const SlkgdhbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: SlkgdhbScreenMobile(),

    );
  }
}
