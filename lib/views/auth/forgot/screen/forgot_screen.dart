import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/core/utils/space.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/primary_button_widget.dart';
import 'package:doda_work/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/layout.dart';
import '../../../../widgets/primary_input_widget.dart';
import '../controller/forgot_controller.dart';

part 'forgot_screen_mobile.dart';

class ForgotScreen extends GetView<ForgotController> {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ForgotScreenMobile());
  }
}
