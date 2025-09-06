import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/text_widget.dart';
import '../controller/category_controller.dart';

part 'category_screen_mobile.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: CategoryScreenMobile());
  }
}
