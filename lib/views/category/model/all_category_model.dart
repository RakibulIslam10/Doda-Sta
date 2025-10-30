class AllCategoryModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<CategoryItem>? data;

  AllCategoryModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory AllCategoryModel.fromJson(Map<String, dynamic> json) => AllCategoryModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CategoryItem>.from(json["data"]!.map((x) => CategoryItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoryItem {
  final String? id;
  final String? name;
  final String? icon;
  final bool? isActive;
  final String? createdBy;
  final List<CategoryItemSubcategory>? subcategories;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  CategoryItem({
    this.id,
    this.name,
    this.icon,
    this.isActive,
    this.createdBy,
    this.subcategories,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
    id: json["_id"],
    name: json["name"],
    icon: json["icon"],
    isActive: json["isActive"],
    createdBy: json["createdBy"],
    subcategories: json["subcategories"] == null ? [] : List<CategoryItemSubcategory>.from(json["subcategories"]!.map((x) => CategoryItemSubcategory.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "icon": icon,
    "isActive": isActive,
    "createdBy": createdBy,
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class CategoryItemSubcategory {
  final String? name;
  final bool? isActive;
  final String? createdBy;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryItemSubcategory({
    this.name,
    this.isActive,
    this.createdBy,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryItemSubcategory.fromJson(Map<String, dynamic> json) => CategoryItemSubcategory(
    name: json["name"],
    isActive: json["isActive"],
    createdBy: json["createdBy"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "isActive": isActive,
    "createdBy": createdBy,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
