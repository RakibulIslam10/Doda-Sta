import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../widgets/text_widget.dart';
import '../../home/screen/home_screen.dart';
import '../controller/home_vendor_controller.dart';

part 'home_vendor_screen_mobile.dart';
part '../widget/vendor_status_card_widget.dart';
part '../widget/tab_bar_view_status_widget.dart';

class HomeVendorScreen extends GetView<HomeVendorController> {
  const HomeVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: HomeVendorScreenMobile());
  }
}
