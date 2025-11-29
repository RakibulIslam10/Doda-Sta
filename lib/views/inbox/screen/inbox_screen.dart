import 'package:doda_work/views/inbox/widget/chat_body.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/inbox_controller.dart';
import '../widget/type_massage.dart';
import 'inbox_screen_mobile.dart';

class InboxScreen extends GetView<InboxController> {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: InboxScreenMobile());
  }
}
