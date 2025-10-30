import 'package:doda_work/core/api/end_point/api_end_points.dart';
import 'package:doda_work/core/api/services/api_request.dart';
import 'package:doda_work/views/notification/model/notification_model.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationController extends GetxController {
  final pagingController = PagingController<int, NotificationItem>(firstPageKey: 1);
  bool isLoading = false;

  Future<void> fetch(int pageKey) async {
    if (isLoading) return;
    isLoading = true;

    try {
      final response = await ApiClient.get(
        url: ApiEndPoints.notification(page: pageKey),
      );

      if (response.statusCode == 200) {
        final newItems = NotificationModel.fromJson(response.body).data?.notification ?? [];
        if (newItems.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error = 'Error fetching data';
      }
    } catch (e) {
      pagingController.error = e.toString();
    } finally {
      isLoading = false;
    }
  }


  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetch(pageKey);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
