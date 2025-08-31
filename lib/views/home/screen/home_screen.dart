import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/text_widget.dart';
import '../controller/home_controller.dart';

part 'home_screen_mobile.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: HomeScreenMobile());
  }
}
