import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../widgets/text_widget.dart';
import '../controller/notification_controller.dart';

part 'notification_screen_mobile.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: NotificationScreenMobile());
  }
}
