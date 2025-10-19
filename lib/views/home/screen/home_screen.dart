import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/views/navigation/controller/navigation_controller.dart';
import 'package:flutter/cupertino.dart';
import '../controller/home_controller.dart';

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
