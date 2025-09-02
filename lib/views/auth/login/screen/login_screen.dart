import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/layout.dart';
import '../../../../gen/assets.gen.dart';
import '../controller/login_controller.dart';
import '../widget/button_section_widget.dart';
import '../widget/field_section_widget.dart';

part 'login_screen_mobile.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: LoginScreenMobile());
  }
}
