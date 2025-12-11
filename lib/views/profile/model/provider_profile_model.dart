class ProviderProfileModel {
  final String id;
  final AuthIdModel? authId;
  final String companyName;
  final String website;
  final List<ServiceCategoryModel> serviceCategories;
  final double latitude;
  final double longitude;
  final int coveredRadius;
  final String serviceLocation;
  final bool isActive;
  final bool isVerified;
  final List<String> licenses;
  final List<String> certificates;
  final double rating;
  final int totalReviews;
  final PendingUpdatesModel? pendingUpdates;
  final dynamic reservedProvider;
  final String? paymentIntentId;
  final List<dynamic> potentialProviders;
  final List<String> attachments;
  final String contactPerson;
  final bool isRejected;

  ProviderProfileModel({
    required this.id,
     this.authId,
    required this.companyName,
    required this.website,
    required this.serviceCategories,
    required this.latitude,
    required this.longitude,
    required this.coveredRadius,
    required this.serviceLocation,
    required this.isActive,
    required this.isVerified,
    required this.licenses,
    required this.certificates,
    required this.rating,
    required this.totalReviews,
    this.pendingUpdates,
    this.reservedProvider,
    this.paymentIntentId,
    required this.potentialProviders,
    required this.attachments,
    required this.contactPerson,
    required this.isRejected,
  });

  factory ProviderProfileModel.fromJson(Map<String, dynamic> json) {
    return ProviderProfileModel(
      id: json["_id"] ?? '',
      authId: json["authId"] != null
          ? AuthIdModel.fromJson(json["authId"])
          : null,
      companyName: json["companyName"] ?? "",
      website: json["website"] ?? "",
      serviceCategories: json["serviceCategories"] != null
          ? (json["serviceCategories"] as List)
          .map((e) => ServiceCategoryModel.fromJson(e))
          .toList()
          : [],
      latitude: (json["latitude"] ?? 0).toDouble(),
      longitude: (json["longitude"] ?? 0).toDouble(),
      coveredRadius: json["coveredRadius"] ?? 0,

      serviceLocation: json["serviceLocation"] ?? "",
      isActive: json["isActive"] ?? false,
      isVerified: json["isVerified"] ?? false,
      licenses: List<String>.from(json["licenses"] ?? []),
      certificates: List<String>.from(json["certificates"] ?? []),
      rating: (json["rating"] ?? 0).toDouble(),
      totalReviews: json["totalReviews"] ?? 0,
      pendingUpdates: json["pendingUpdates"] != null
          ? PendingUpdatesModel.fromJson(json["pendingUpdates"])
          : null,
      reservedProvider: json["reservedProvider"],
      paymentIntentId: json["paymentIntentId"],
      potentialProviders: json["potentialProviders"] ?? [],

      attachments: List<String>.from(json["attachments"] ?? []),
      contactPerson: json["contactPerson"] ?? "",
      isRejected: json["isRejected"] ?? false,

    );
  }
}

class AuthIdModel {
  final String id;
  final String name;
  final String email;

  AuthIdModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory AuthIdModel.fromJson(Map<String, dynamic> json) {
    return AuthIdModel(
      id: json["_id"],
      name: json["name"] ?? "",
      email: json["email"] ?? "",
    );
  }
}

class ServiceCategoryModel {
  final String id;
  final String name;
  final String icon;

  ServiceCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json["_id"],
      name: json["name"] ?? "",
      icon: json["icon"] ?? "",
    );
  }
}

class WorkingHourModel {
  final String day;
  final String startTime;
  final String endTime;
  final bool isAvailable;
  final String id;

  WorkingHourModel({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.id,
  });

  factory WorkingHourModel.fromJson(Map<String, dynamic> json) {
    return WorkingHourModel(
      day: json["day"] ?? "",
      startTime: json["startTime"] ?? "",
      endTime: json["endTime"] ?? "",
      isAvailable: json["isAvailable"] ?? false,
      id: json["_id"] ?? "",
    );
  }
}

class PendingUpdatesModel {
  final String? companyName;
  final String? website;
  final String? serviceLocation;
  final int? coveredRadius;
  final String? contactPerson;
  final double? latitude;
  final double? longitude;
  final String? profileImage;

  PendingUpdatesModel({
    this.companyName,
    this.website,
    this.serviceLocation,
    this.coveredRadius,
    this.contactPerson,
    this.latitude,
    this.longitude,
    this.profileImage,
  });

  factory PendingUpdatesModel.fromJson(Map<String, dynamic> json) {
    return PendingUpdatesModel(
      companyName: json["companyName"],
      website: json["website"],
      serviceLocation: json["serviceLocation"],
      coveredRadius: json["coveredRadius"],
      contactPerson: json["contactPerson"],
      latitude: json["latitude"]?.toDouble(),
      longitude: json["longitude"]?.toDouble(),
      profileImage: json["profile_image"],
    );
  }
}

class StatsModel {
  final int totalAssignedRequests;
  final int totalCompletedRequests;
  final int totalPendingRequests;
  final double acceptanceRate;

  StatsModel({
    required this.totalAssignedRequests,
    required this.totalCompletedRequests,
    required this.totalPendingRequests,
    required this.acceptanceRate,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      totalAssignedRequests: json["totalAssignedRequests"] ?? 0,
      totalCompletedRequests: json["totalCompletedRequests"] ?? 0,
      totalPendingRequests: json["totalPendingRequests"] ?? 0,
      acceptanceRate: (json["acceptanceRate"] ?? 0).toDouble(),
    );
  }
}
