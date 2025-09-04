import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/core/utils/space.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/primary_button_widget.dart';
import 'package:doda_work/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../request/screen/request_screen.dart';
import '../controller/summary_controller.dart';

part 'summary_screen_mobile.dart';
part '../widget/buttons_section_widget.dart';
part '../widget/image_header_widget.dart';
part '../widget/request_text_box_widget.dart';

class SummaryScreen extends GetView<SummaryController> {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: SummaryScreenMobile());
  }
}
