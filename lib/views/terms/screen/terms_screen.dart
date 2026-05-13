import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/layout.dart';
import '../controller/terms_controller.dart';
import 'terms_screen_mobile.dart';

class TermsScreen extends GetView<TermsController> {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: TermsScreenMobile());
  }
}
