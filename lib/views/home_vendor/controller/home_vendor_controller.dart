import '../../../core/utils/basic_import.dart';
import 'package:doda_work/views/home/model/home_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeVendorController extends GetxController {
  final RxInt selectedStatus = 0.obs;

  final Map<String, PagingController<int, HomeServiceItem>> pagingControllers = {
    "PENDING": PagingController(firstPageKey: 1),
    "ACCEPTED": PagingController(firstPageKey: 1),
    "COMPLETED": PagingController(firstPageKey: 1),
    "DECLINED": PagingController(firstPageKey: 1),
  };

  final Map<String, bool> isLoadingMap = {
    "PENDING": false,
    "ACCEPTED": false,
    "COMPLETED": false,
    "DECLINED": false,
  };

  Future<void> fetch(String status, int pageKey) async {
    if (isLoadingMap[status] == true) return;
    isLoadingMap[status] = true;

    try {
      final response = await ApiClient.get(
        url: ApiEndPoints.providerService(status: status, page: pageKey),
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

  final RxBool isLoading = false.obs;

  Future<void> changeStatus({required String status, required String id}) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final response = await ApiClient.patch(
        body: {
          "requestId": id,
          "action": status,
        },
        url: ApiEndPoints.providerChangeStatus(),
      );

      if (response.statusCode == 200) {
        pagingControllers.forEach((key, controller) {
          controller.refresh();
        });

        Get.snackbar(
          "Success",
          "Status updated successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          response.body?["message"] ?? "Something went wrong!",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    pagingControllers.forEach((_, controller) => controller.dispose());
    super.onClose();
  }
}
