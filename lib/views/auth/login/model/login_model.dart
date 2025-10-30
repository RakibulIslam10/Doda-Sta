class LoginModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  LoginModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final User user;
  final String accessToken;

  Data({required this.user, required this.accessToken});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(user: User.fromJson(json["user"]), accessToken: json["accessToken"]);
}

class User {
  final String id;
  final AuthId authId;
  final List<dynamic> serviceCategories;
  final bool isActive;
  final bool isVerified;
  final List<dynamic> attachments;
  final int rating;
  final int totalReviews;
  final dynamic pendingUpdates;
  final dynamic reservedProvider;
  final dynamic paymentIntentId;
  final List<dynamic> workingHours;
  final List<dynamic> potentialProviders;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  User({
    required this.id,
    required this.authId,
    required this.serviceCategories,
    required this.isActive,
    required this.isVerified,
    required this.attachments,
    required this.rating,
    required this.totalReviews,
    required this.pendingUpdates,
    required this.reservedProvider,
    required this.paymentIntentId,
    required this.workingHours,
    required this.potentialProviders,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    authId: AuthId.fromJson(json["authId"]),
    serviceCategories: List<dynamic>.from(
      json["serviceCategories"].map((x) => x),
    ),
    isActive: json["isActive"],
    isVerified: json["isVerified"],
    attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
    rating: json["rating"],
    totalReviews: json["totalReviews"],
    pendingUpdates: json["pendingUpdates"],
    reservedProvider: json["reservedProvider"],
    paymentIntentId: json["paymentIntentId"],
    workingHours: List<dynamic>.from(json["workingHours"].map((x) => x)),
    potentialProviders: List<dynamic>.from(
      json["potentialProviders"].map((x) => x),
    ),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}

class AuthId {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isBlocked;
  final bool isActive;
  final bool isPhoneVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AuthId({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isBlocked,
    required this.isActive,
    required this.isPhoneVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AuthId.fromJson(Map<String, dynamic> json) => AuthId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    isBlocked: json["isBlocked"],
    isActive: json["isActive"],
    isPhoneVerified: json["isPhoneVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}
