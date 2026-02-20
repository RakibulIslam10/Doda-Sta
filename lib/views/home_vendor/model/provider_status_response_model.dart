class ProviderStatusResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final ResponseData data;

  ProviderStatusResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProviderStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return ProviderStatusResponseModel(
      statusCode: json["statusCode"] != null
          ? (json["statusCode"] as num).toInt()
          : 0,
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: ResponseData.fromJson(json["data"] ?? {}),
    );
  }
}

class ResponseData {
  final String message;
  final bool requiresPayment;
  final int leadFee;
  final String paymentUrl;
  final String sessionId;

  ResponseData({
    required this.message,
    required this.requiresPayment,
    required this.leadFee,
    required this.paymentUrl,
    required this.sessionId,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      message: json["message"] ?? "",
      requiresPayment: json["requiresPayment"] ?? false,
      leadFee: json["leadFee"] != null
          ? (json["leadFee"] as num).toInt()
          : 0,
      paymentUrl: json["paymentUrl"] ?? "",
      sessionId: json["sessionId"] ?? "",
    );
  }
}
