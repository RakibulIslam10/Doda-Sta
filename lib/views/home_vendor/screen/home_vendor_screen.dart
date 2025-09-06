import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/home_vendor_controller.dart';

part 'home_vendor_screen_mobile.dart';

class HomeVendorScreen extends GetView<HomeVendorController> {
  const HomeVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: HomeVendorScreenMobile());
  }
}
