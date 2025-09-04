import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/text_widget.dart';
import '../controller/all_category_controller.dart';

part 'all_category_screen_mobile.dart';

class AllCategoryScreen extends GetView<AllCategoryController> {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: AllCategoryScreenMobile());
  }
}
