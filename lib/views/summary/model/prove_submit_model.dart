class ProveSubmitedModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  ProveSubmitedModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProveSubmitedModel.fromJson(Map<String, dynamic> json) => ProveSubmitedModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final String status;
  final String message;

  Data({
    required this.status,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
