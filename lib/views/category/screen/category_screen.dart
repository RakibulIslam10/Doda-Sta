import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../widgets/text_widget.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../controller/category_controller.dart';

part 'category_screen_mobile.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: CategoryScreenMobile());
  }
}
