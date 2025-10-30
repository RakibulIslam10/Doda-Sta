class ProviderUpdateProfileModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  ProviderUpdateProfileModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProviderUpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      ProviderUpdateProfileModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String message;

  Data({required this.message});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(message: json["message"]);
}
