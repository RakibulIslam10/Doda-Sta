import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/vendor_phone_controller.dart';

part 'vendor_phone_screen_mobile.dart';

class VendorPhoneScreen extends GetView<VendorPhoneController> {
  const VendorPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: VendorPhoneScreenMobile());
  }
}
