
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/space.dart';
import 'package:doda_work/views/category/screen/category_screen.dart';
import 'package:doda_work/views/chat/screen/chat_screen.dart';

import 'package:doda_work/views/home/screen/home_screen.dart';
import 'package:doda_work/views/profile/screen/profile_screen.dart';
import 'package:doda_work/views/request/screen/request_screen.dart';

import '../controller/navigation_controller.dart';

part 'navigation_screen_mobile.dart';

class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: NavigationScreenMobile());
  }
}
