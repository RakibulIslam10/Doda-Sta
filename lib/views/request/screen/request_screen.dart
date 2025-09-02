import 'package:doda_work/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/request_controller.dart';

part 'request_screen_mobile.dart';

class RequestScreen extends GetView<RequestController> {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: RequestScreenMobile());
  }
}
