class ProviderReviewModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final ProviderReviewData? data;

  ProviderReviewModel({this.statusCode, this.success, this.message, this.data});

  factory ProviderReviewModel.fromJson(Map<String, dynamic> json) {
    return ProviderReviewModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? ProviderReviewData.fromJson(json['data']) : null,
    );
  }
}

class ProviderReviewData {
  final Meta? meta;
  final List<ReviewResult>? result;
  final double? avgRating;

  ProviderReviewData({this.meta, this.result, this.avgRating});

  factory ProviderReviewData.fromJson(Map<String, dynamic> json) {
    return ProviderReviewData(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      result: json['result'] != null
          ? List<ReviewResult>.from(json['result'].map((x) => ReviewResult.fromJson(x)))
          : [],
      avgRating: (json['avgRating'] ?? 0).toDouble(),
    );
  }
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;
  final int? totalReviews;

  Meta({this.page, this.limit, this.total, this.totalPage, this.totalReviews});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
      totalReviews: json['totalReviews'],
    );
  }
}

class ReviewResult {
  final String? id;
  final User? user;
  final double? rating;
  final String? review;
  final String? providerId;
  final String? createdAt;
  final String? updatedAt;

  ReviewResult({this.id, this.user, this.rating, this.review, this.providerId, this.createdAt, this.updatedAt});

  factory ReviewResult.fromJson(Map<String, dynamic> json) {
    return ReviewResult(
      id: json['_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      rating: (json['rating'] ?? 0).toDouble(),
      review: json['review'],
      providerId: json['providerId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class User {
  final String? id;
  final String? authId;
  final String? name;
  final String? email;
  final String? profileImage;
  final String? phoneNumber;
  final Favorites? favorites;
  final String? latitude;
  final String? longitude;

  User({this.id, this.authId, this.name, this.email, this.profileImage, this.phoneNumber, this.favorites, this.latitude, this.longitude});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      authId: json['authId'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profile_image'],
      phoneNumber: json['phoneNumber'],
      favorites: json['favorites'] != null ? Favorites.fromJson(json['favorites']) : null,
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Favorites {
  final List<FavoriteCategory>? categories;

  Favorites({this.categories});

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      categories: json['categories'] != null
          ? List<FavoriteCategory>.from(json['categories'].map((x) => FavoriteCategory.fromJson(x)))
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
