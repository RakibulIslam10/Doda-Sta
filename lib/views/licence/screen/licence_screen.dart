import 'package:doda_work/core/utils/basic_import.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/primary_button_widget.dart';
import '../controller/licence_controller.dart';

part 'licence_screen_mobile.dart';

class LicenceScreen extends GetView<LicenceController> {
  const LicenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: LicenceScreenMobile());
  }
}
