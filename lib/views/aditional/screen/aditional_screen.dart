import 'dart:io';

import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/views/auth/register/controller/register_controller.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/widgets/loading_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/helpers/helpers.dart';
import '../../../widgets/location_picker_widget.dart';
import '../../../widgets/time_picker_widget.dart';
import '../../request/widget/category_widget.dart';
import '../controller/aditional_controller.dart';

part 'aditional_screen_mobile.dart';
part 'provider_preview_widget.dart';


class AditionalScreen extends GetView<AditionalController> {
  const AditionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: AditionalScreenMobile());
  }
}
