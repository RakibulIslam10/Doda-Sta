import 'dart:io';

import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import '../../../core/helpers/helpers.dart';
import '../../../widgets/location_picker_widget.dart';
import '../../profile/controller/profile_controller.dart';
import '../controller/update_controller.dart';

part 'update_screen_mobile.dart';

class UpdateScreen extends GetView<UpdateController> {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: UpdateScreenMobile());
  }
}
