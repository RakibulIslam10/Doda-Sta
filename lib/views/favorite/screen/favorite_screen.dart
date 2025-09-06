import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/divider_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controller/favorite_controller.dart';

part 'favorite_screen_mobile.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: FavoriteScreenMobile());
  }
}
