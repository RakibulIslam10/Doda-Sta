class ProviderRegisterModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  ProviderRegisterModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProviderRegisterModel.fromJson(Map<String, dynamic> json) =>
      ProviderRegisterModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String authId;
  final String companyName;
  final String website;
  final List<String> serviceCategories;
  final double latitude;
  final double longitude;
  final int coveredRadius;
  final List<WorkingHour> workingHours;
  final String serviceLocation;
  final String contactPerson;
  final bool isActive;
  final bool isVerified;
  final List<dynamic> attachments;
  final int rating;
  final int totalReviews;
  final dynamic pendingUpdates;
  final dynamic reservedProvider;
  final dynamic paymentIntentId;
  final String id;
  final List<dynamic> potentialProviders;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Data({
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
    required this.attachments,
    required this.rating,
    required this.totalReviews,
    required this.pendingUpdates,
    required this.reservedProvider,
    required this.paymentIntentId,
    required this.id,
    required this.potentialProviders,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    authId: json["authId"],
    companyName: json["companyName"],
    website: json["website"],
    serviceCategories: List<String>.from(
      json["serviceCategories"].map((x) => x),
    ),
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    coveredRadius: json["coveredRadius"],
    workingHours: List<WorkingHour>.from(
      json["workingHours"].map((x) => WorkingHour.fromJson(x)),
    ),
    serviceLocation: json["serviceLocation"],
    contactPerson: json["contactPerson"],
    isActive: json["isActive"],
    isVerified: json["isVerified"],
    attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
    rating: json["rating"],
    totalReviews: json["totalReviews"],
    pendingUpdates: json["pendingUpdates"],
    reservedProvider: json["reservedProvider"],
    paymentIntentId: json["paymentIntentId"],
    id: json["_id"],
    potentialProviders: List<dynamic>.from(
      json["potentialProviders"].map((x) => x),
    ),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
