import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/core/utils/space.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../widgets/primary_input_widget.dart';
import '../controller/update_controller.dart';

part 'update_screen_mobile.dart';

class UpdateScreen extends GetView<UpdateController> {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: UpdateScreenMobile());
  }
}
