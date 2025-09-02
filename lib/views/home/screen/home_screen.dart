import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/text_widget.dart';
import '../controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

part 'home_screen_mobile.dart';
part '../widget/category_widget.dart';
part '../widget/home_app_bar_widget.dart';
part '../widget/services_list_widget.dart';
part '../widget/status_widget.dart';
part '../widget/search_bar_widget.dart';
part '../widget/custom_status_card_widget_widget.dart';


class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: HomeScreenMobile());
  }
}
