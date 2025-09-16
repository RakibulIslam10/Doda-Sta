import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/core/utils/space.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/views/request/widget/category_widget.dart';
import 'package:doda_work/widgets/date_picker_widget.dart';
import 'package:doda_work/widgets/primary_button_widget.dart';
import 'package:doda_work/widgets/primary_input_widget.dart';
import 'package:doda_work/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/custom_drop_down_widget.dart';
import '../../../widgets/time_picker_widget.dart';
import '../controller/request_controller.dart';
import 'package:intl/intl.dart';

part 'request_screen_mobile.dart';

part '../widget/time_and_date_section_widget.dart';

part '../widget/others_field_widget.dart';

part '../widget/add_photo_box_widget.dart';

part '../widget/request_info_card_widget.dart';

class RequestScreen extends GetView<RequestController> {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: RequestScreenMobile());
  }
}
