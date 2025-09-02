import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/core/utils/space.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/themes/token.dart';
import '../../../../widgets/auth_app_bar.dart';
import '../../../../widgets/text_widget.dart';
import '../../../../widgets/timer_widget.dart';
import '../controller/verification_controller.dart';

part 'verification_screen_mobile.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: VerificationScreenMobile());
  }
}
