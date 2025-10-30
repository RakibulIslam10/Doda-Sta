class UserUpdateProfileModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  UserUpdateProfileModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserUpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UserUpdateProfileModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final Favorites favorites;
  final String id;
  final AuthId authId;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String address;
  final String latitude;
  final String longitude;

  Data({
    required this.favorites,
    required this.id,
    required this.authId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    favorites: Favorites.fromJson(json["favorites"]),
    id: json["_id"],
    authId: AuthId.fromJson(json["authId"]),
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
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

class Favorites {
  final List<dynamic> categories;

  Favorites({required this.categories});

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
  );
}
