class BasicSuccessModel {
  final int statusCode;
  final bool success;
  final String message;

  BasicSuccessModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  factory BasicSuccessModel.fromJson(Map<String, dynamic> json) =>
      BasicSuccessModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
      );
}
