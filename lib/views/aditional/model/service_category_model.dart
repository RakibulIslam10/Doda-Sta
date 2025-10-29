class ServiceCategoryModel {
  final int statusCode;
  final bool success;
  final String message;
  final List<ServiceCategory> category;

  ServiceCategoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.category,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      ServiceCategoryModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        category: List<ServiceCategory>.from(
          json["data"].map((x) => ServiceCategory.fromJson(x)),
        ),
      );
}

class ServiceCategory {
  final String id;
  final String name;
  final String icon;
  final bool isActive;
  final String createdBy;
  final List<Subcategory> subcategories;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.isActive,
    required this.createdBy,
    required this.subcategories,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      ServiceCategory(
        id: json["_id"],
        name: json["name"],
        icon: json["icon"],
        isActive: json["isActive"],
        createdBy: json["createdBy"],
        subcategories: List<Subcategory>.from(
          json["subcategories"].map((x) => Subcategory.fromJson(x)),
        ),
      );
}

class Subcategory {
  final String name;
  final bool isActive;
  final String createdBy;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subcategory({
    required this.name,
    required this.isActive,
    required this.createdBy,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    name: json["name"],
    isActive: json["isActive"],
    createdBy: json["createdBy"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
}
