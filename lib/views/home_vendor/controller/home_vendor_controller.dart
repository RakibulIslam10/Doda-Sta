import '../../../core/utils/basic_import.dart';
import 'package:doda_work/views/home/model/home_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeVendorController extends GetxController {
  final RxInt selectedStatus = 0.obs;
  final RxBool isLoading = false.obs;

  // Constants for status types
  static const List<String> statusTypes = [
    "PENDING",
    "ACCEPTED",
    "COMPLETED",
    "DECLINED",
  ];

  final Map<String, PagingController<int, HomeServiceItem>> pagingControllers = {
    for (var status in statusTypes)
      status: PagingController(firstPageKey: 1),
  };

  final Map<String, bool> isLoadingMap = {
    for (var status in statusTypes)
      status: false,
  };

  @override
  void onInit() {
    _initializePagingControllers();
    fetch("PENDING", 1);
    super.onInit();
  }

  void _initializePagingControllers() {
    for (final entry in pagingControllers.entries) {
      final status = entry.key;
      final controller = entry.value;

      controller.addPageRequestListener((pageKey) {
        fetch(status, pageKey);
      });
    }
  }

  Future<void> fetch(String status, int pageKey) async {
    // Prevent multiple simultaneous requests for same status
    if (isLoadingMap[status] == true) return;

    isLoadingMap[status] = true;

    try {
      final response = await ApiClient.get(
        url: ApiEndPoints.providerService(status: status, page: pageKey),
      );

      final controller = pagingControllers[status]!;

      if (response.statusCode == 200) {
        await _handleSuccessResponse(response, controller, pageKey);
      } else {
        _handleErrorResponse(controller, response);
      }
    } catch (e) {
      _handleException(status, e);
    } finally {
      isLoadingMap[status] = false;
    }
  }

  Future<void> _handleSuccessResponse(
      dynamic response,
      PagingController<int, HomeServiceItem> controller,
      int pageKey
      ) async {
    try {
      final homeModel = HomeModel.fromJson(response.body);
      final newItems = homeModel.data?.requests ?? [];

      // Since there's no meta data, use a simple pagination approach
      // Assume there are more pages if we got a non-empty list
      // You might need to adjust this based on your API's actual behavior
      if (newItems.isNotEmpty) {
        final nextPageKey = pageKey + 1;
        controller.appendPage(newItems, nextPageKey);
      } else {
        controller.appendLastPage(newItems);
      }
    } catch (e) {
      controller.error = 'Failed to parse response: $e';
    }
  }

  void _handleErrorResponse(
      PagingController<int, HomeServiceItem> controller,
      dynamic response
      ) {
    final errorMessage = response.body?["message"] ?? "Failed to load data";
    controller.error = errorMessage;

    // Show error snackbar for first page errors only
    if (controller.firstPageKey == 1) {
      Get.snackbar(
        "Error",
        errorMessage,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void _handleException(String status, Object e) {
    pagingControllers[status]!.error = e.toString();

    // Log the error for debugging
    print('Error fetching $status requests: $e');
  }

  Future<void> changeStatus({
    required String status,
    required String id
  }) async {
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
        await _handleStatusChangeSuccess();
      } else {
        _handleStatusChangeError(response);
      }
    } catch (e) {
      _handleStatusChangeException(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handleStatusChangeSuccess() async {
    // Refresh all controllers to reflect status changes
    for (final controller in pagingControllers.values) {
      controller.refresh();
    }

    Get.snackbar(
      "Success",
      "Status updated successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _handleStatusChangeError(dynamic response) {
    final errorMessage = response.body?["message"] ?? "Something went wrong!";

    Get.snackbar(
      "Error",
      errorMessage,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void _handleStatusChangeException(Object e) {
    Get.snackbar(
      "Error",
      "Network error occurred. Please try again.",
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );

    // Log the error
    print('Error changing status: $e');
  }

  // Helper method to refresh all tabs
  Future<void> refreshAll() async {
    for (final controller in pagingControllers.values) {
      controller.refresh();
    }
  }

  // Helper method to get status by index
  String getStatusByIndex(int index) {
    return statusTypes[index];
  }

  // Helper method to get current status
  String get currentStatus => statusTypes[selectedStatus.value];

  @override
  void onClose() {
    for (final controller in pagingControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}