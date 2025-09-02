import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/layout.dart';
import '../../../../core/utils/space.dart';
import '../../../../widgets/auth_app_bar.dart';
import '../../../../widgets/primary_input_widget.dart';
import '../controller/reset_controller.dart';

part 'reset_screen_mobile.dart';

class ResetScreen extends GetView<ResetController> {
  const ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ResetScreenMobile());
  }
}
