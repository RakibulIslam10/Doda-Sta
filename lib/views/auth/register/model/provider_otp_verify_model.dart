class ProviderOtpVerify {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  ProviderOtpVerify({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProviderOtpVerify.fromJson(Map<String, dynamic> json) =>
      ProviderOtpVerify(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String accessToken;
  final String refreshToken;

  Data({required this.accessToken, required this.refreshToken});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );
}
