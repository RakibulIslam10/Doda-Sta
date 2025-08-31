import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/text_widget.dart';
import '../controller/welcome_controller.dart';

part 'welcome_screen_mobile.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: WelcomeScreenMobile());
  }
}
