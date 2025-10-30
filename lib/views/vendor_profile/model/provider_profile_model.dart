class ProviderProfileModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  ProviderProfileModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProviderProfileModel.fromJson(Map<String, dynamic> json) =>
      ProviderProfileModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String id;
  final AuthId authId;
  final String companyName;
  final String website;
  final List<ServiceCategory> serviceCategories;
  final double latitude;
  final double longitude;
  final int coveredRadius;
  final List<WorkingHour> workingHours;
  final String serviceLocation;
  final ContactPerson contactPerson;
  final bool isActive;
  final bool isVerified;
  final List<String> licenses;
  final List<dynamic> certificates;
  final int rating;
  final int totalReviews;
  final dynamic pendingUpdates;
  final dynamic reservedProvider;
  final dynamic paymentIntentId;
  final List<dynamic> potentialProviders;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final Stats stats;

  Data({
    required this.id,
    required this.authId,
    required this.companyName,
    required this.website,
    required this.serviceCategories,
    required this.latitude,
    required this.longitude,
    required this.coveredRadius,
    required this.workingHours,
    required this.serviceLocation,
    required this.contactPerson,
    required this.isActive,
    required this.isVerified,
    required this.licenses,
    required this.certificates,
    required this.rating,
    required this.totalReviews,
    required this.pendingUpdates,
    required this.reservedProvider,
    required this.paymentIntentId,
    required this.potentialProviders,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.stats,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    authId: AuthId.fromJson(json["authId"]),
    companyName: json["companyName"] ?? "",
    website: json["website"] ?? '',
    serviceCategories: List<ServiceCategory>.from(
      json["serviceCategories"].map((x) => ServiceCategory.fromJson(x)),
    ),
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    coveredRadius: json["coveredRadius"],
    workingHours: List<WorkingHour>.from(
      json["workingHours"].map((x) => WorkingHour.fromJson(x)),
    ),
    serviceLocation: json["serviceLocation"],
    contactPerson: ContactPerson.fromJson(json["contactPerson"]),
    isActive: json["isActive"],
    isVerified: json["isVerified"],
    licenses: List<String>.from(json["licenses"].map((x) => x)),
    certificates: List<dynamic>.from(json["certificates"].map((x) => x)),
    rating: json["rating"],
    totalReviews: json["totalReviews"],
    pendingUpdates: json["pendingUpdates"],
    reservedProvider: json["reservedProvider"],
    paymentIntentId: json["paymentIntentId"],
    potentialProviders: List<dynamic>.from(
      json["potentialProviders"].map((x) => x),
    ),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    stats: Stats.fromJson(json["stats"]),
  );
}

class AuthId {
  final String id;
  final String name;
  final String email;

  AuthId({required this.id, required this.name, required this.email});

  factory AuthId.fromJson(Map<String, dynamic> json) =>
      AuthId(id: json["_id"], name: json["name"], email: json["email"]);
}

class ContactPerson {
  final String name;
  final String email;
  final String phone;

  ContactPerson({required this.name, required this.email, required this.phone});

  factory ContactPerson.fromJson(Map<String, dynamic> json) => ContactPerson(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
  );
}

class ServiceCategory {
  final String id;
  final String name;
  final String icon;

  ServiceCategory({required this.id, required this.name, required this.icon});

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      ServiceCategory(id: json["_id"], name: json["name"], icon: json["icon"]);
}

class Stats {
  final int totalAssignedRequests;
  final int totalCompletedRequests;
  final int totalPendingRequests;
  final int acceptanceRate;

  Stats({
    required this.totalAssignedRequests,
    required this.totalCompletedRequests,
    required this.totalPendingRequests,
    required this.acceptanceRate,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    totalAssignedRequests: json["totalAssignedRequests"],
    totalCompletedRequests: json["totalCompletedRequests"],
    totalPendingRequests: json["totalPendingRequests"],
    acceptanceRate: json["acceptanceRate"],
  );
}

class WorkingHour {
  final String day;
  final String startTime;
  final String endTime;
  final bool isAvailable;
  final String id;

  WorkingHour({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.id,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) => WorkingHour(
    day: json["day"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    isAvailable: json["isAvailable"],
    id: json["_id"],
  );
}
