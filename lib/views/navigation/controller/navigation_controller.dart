import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/navigation/model/navigation_model.dart';

class NavigationController extends GetxController {
  final List<NavigationModel> navigationList = [
    NavigationModel(iconPath: Assets.icons.vector, name: "Home"),
  ];
}
