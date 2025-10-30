import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/views/category/controller/category_controller.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/divider_widget.dart';
import 'package:doda_work/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/category_preview_controller.dart';

part 'category_preview_screen_mobile.dart';

class CategoryPreviewScreen extends GetView<CategoryPreviewController> {
  const CategoryPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: CategoryPreviewScreenMobile());
  }
}
