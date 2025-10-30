import 'package:doda_work/views/home/model/home_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/utils/basic_import.dart';

class HomeController extends GetxController {
  final RxInt selectedStatus = 0.obs;

  final Map<String, PagingController<int, HomeServiceItem>> pagingControllers = {
    "PENDING": PagingController(firstPageKey: 1),
    "ONGOING": PagingController(firstPageKey: 1),
    "COMPLETED": PagingController(firstPageKey: 1),
  };

  final Map<String, bool> isLoadingMap = {
    "PENDING": false,
    "ONGOING": false,
    "COMPLETED": false,
  };

  Future<void> fetch(String status, int pageKey) async {
    if (isLoadingMap[status] == true) return;
    isLoadingMap[status] = true;

    try {
      final response = await ApiClient.get(
        url: ApiEndPoints.myService(status: status, page: pageKey),
      );

      final controller = pagingControllers[status]!;

      if (response.statusCode == 200) {
        final newItems = HomeModel.fromJson(response.body).data?.requests ?? [];
        if (newItems.isEmpty) {
          controller.appendLastPage(newItems);
        } else {
          controller.appendPage(newItems, pageKey + 1);
        }
      } else {
        controller.error = 'Error fetching data';
      }
    } catch (e) {
      pagingControllers[status]!.error = e.toString();
    } finally {
      isLoadingMap[status] = false;
    }
  }

  @override
  void onInit() {
    pagingControllers.forEach((status, controller) {
      controller.addPageRequestListener((pageKey) {
        fetch(status, pageKey);
      });
    });

    fetch("PENDING", 1);

    super.onInit();
  }

  @override
  void onClose() {
    pagingControllers.forEach((_, controller) => controller.dispose());
    super.onClose();
  }
}

