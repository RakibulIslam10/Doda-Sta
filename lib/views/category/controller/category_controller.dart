import 'package:doda_work/core/api/end_point/api_end_points.dart';
import 'package:doda_work/core/api/services/api_request.dart';
import 'package:get/get.dart';

import '../model/all_category_model.dart';

class CategoryController extends GetxController {
  var expandedIndex = (-1).obs;

  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  final RxList<CategoryItem> allCategory = <CategoryItem>[].obs;
  final RxList<CategoryItem> filteredCategory = <CategoryItem>[].obs;
  final RxList<CategoryItemSubcategory> availableSubcategories = <CategoryItemSubcategory>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> getCategory() async {
    try {
      isLoading.value = true;
      final data = await ApiClient.get(url: ApiEndPoints.categoryAll);
      if (data.statusCode == 200) {
        final allItems = AllCategoryModel.fromJson(data.body);
        allCategory.assignAll(allItems.data ?? []);
        filteredCategory.assignAll(
          allCategory.where((c) => (c.subcategories?.isNotEmpty ?? false)).toList(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void filterSubcategories(String categoryId) {
    final category = allCategory.firstWhereOrNull((c) => c.id == categoryId);
    availableSubcategories.assignAll(category?.subcategories ?? []);
  }

  @override
  void onReady() {
    getCategory();
    super.onReady();
  }
}
