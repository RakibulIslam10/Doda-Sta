class ReviewRatingModel {
  final String id;
  final String? reviewerName;
  final String? reviewerImage;
  final double rating;
  final String review;
  final String providerId;
  final DateTime createdAt;

  ReviewRatingModel({
    required this.id,
    required this.reviewerName,
    required this.reviewerImage,
    required this.rating,
    required this.review,
    required this.providerId,
    required this.createdAt,
  });

  factory ReviewRatingModel.fromJson(Map<String, dynamic> json) {
    return ReviewRatingModel(
      id: json["_id"],
      reviewerName: json["user"]?["name"] ?? "Unknown User",
      reviewerImage: json["user"]?["image"] ??
          "https://cdn-icons-png.flaticon.com/512/149/149071.png",
      rating: (json["rating"] as num).toDouble(),
      review: json["review"] ?? "",
      providerId: json["providerId"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
