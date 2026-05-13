import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/routes/routes.dart';
import '../controller/home_controller.dart';
import '../model/home_model.dart';
import 'home_screen_mobile.dart';

part '../widget/services_list_widget.dart';
part '../widget/custom_status_card_widget_widget.dart';


class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: HomeScreenMobile());
  }
}
