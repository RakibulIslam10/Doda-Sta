class UserProfileModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final UserData? data;

  UserProfileModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String? id;
  final AuthId? authId;
  final String? name;
  final String? email;
  final String? profileImage;
  final String? phoneNumber;
  final Favorites? favorites;
  final String? createdAt;
  final String? updatedAt;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? dateOfBirth;

  UserData({
    this.id,
    this.authId,
    this.name,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.favorites,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude, this.address, this.dateOfBirth,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      authId: json['authId'] != null ? AuthId.fromJson(json['authId']) : null,
      name: json['name'],
      email: json['email'],
      profileImage: json['profile_image'],
      phoneNumber: json['phoneNumber'],
      favorites: json['favorites'] != null ? Favorites.fromJson(json['favorites']) : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      dateOfBirth: json['dateOfBirth'],
    );
  }

}

class AuthId {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? provider;
  final String? role;
  final bool? isBlocked;
  final bool? isActive;
  final String? phoneNumber;
  final bool? isPhoneVerified;
  final String? createdAt;
  final String? updatedAt;

  AuthId({
    this.id,
    this.name,
    this.email,
    this.password,
    this.provider,
    this.role,
    this.isBlocked,
    this.isActive,
    this.phoneNumber,
    this.isPhoneVerified,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthId.fromJson(Map<String, dynamic> json) {
    return AuthId(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      provider: json['provider'],
      role: json['role'],
      isBlocked: json['isBlocked'],
      isActive: json['isActive'],
      phoneNumber: json['phoneNumber'],
      isPhoneVerified: json['isPhoneVerified'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

}

class Favorites {
  final List<FavoriteCategory>? categories;

  Favorites({this.categories});

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      categories: json['categories'] != null
          ? List<FavoriteCategory>.from(
        json['categories'].map((x) => FavoriteCategory.fromJson(x)),
      )
          : [],
    );
  }

}

class FavoriteCategory {
  final String? categoryId;
  final String? id;

  FavoriteCategory({this.categoryId, this.id});

  factory FavoriteCategory.fromJson(Map<String, dynamic> json) {
    return FavoriteCategory(
      categoryId: json['categoryId'],
      id: json['_id'],
    );
  }
}
