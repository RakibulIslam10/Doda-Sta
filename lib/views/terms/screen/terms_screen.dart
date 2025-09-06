import 'package:doda_work/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../widgets/auth_app_bar.dart';
import '../controller/terms_controller.dart';

part 'terms_screen_mobile.dart';

class TermsScreen extends GetView<TermsController> {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: TermsScreenMobile());
  }
}
