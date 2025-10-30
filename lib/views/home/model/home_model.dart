class HomeModel {
  final num? statusCode;
  final bool? success;
  final String? message;
  final Data? data;

  HomeModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final List<HomeServiceItem>? requests;
  final bool? success;
  final String? message;

  Data({
    this.requests,
    this.success,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    requests: json["requests"] == null ? [] : List<HomeServiceItem>.from(json["requests"]!.map((x) => HomeServiceItem.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "requests": requests == null ? [] : List<dynamic>.from(requests!.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class HomeServiceItem {
  final String? id;
  final CustomerId? customerId;
  final String? customerPhone;
  final ServiceCategory? serviceCategory;
  final String? subcategory;
  final String? priority;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? startTime;
  final String? endTime;
  final String? address;
  final num? latitude;
  final num? longitude;
  final String? description;
  final List<String?>? attachments;
  final String? status;
  final num? leadFee;
  final String? paymentStatus;
  final List<dynamic>? completionProof;
  final List<dynamic>? potentialProviders;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? requestId;

  HomeServiceItem({
    this.id,
    this.customerId,
    this.customerPhone,
    this.serviceCategory,
    this.subcategory,
    this.priority,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.address,
    this.latitude,
    this.longitude,
    this.description,
    this.attachments,
    this.status,
    this.leadFee,
    this.paymentStatus,
    this.completionProof,
    this.potentialProviders,
    this.createdAt,
    this.updatedAt,
    this.requestId,
  });

  factory HomeServiceItem.fromJson(Map<String, dynamic> json) => HomeServiceItem(
    id: json["_id"],
    customerId: json["customerId"] == null ? null : CustomerId.fromJson(json["customerId"]),
    customerPhone: json["customerPhone"],
    serviceCategory: json["serviceCategory"] == null ? null : ServiceCategory.fromJson(json["serviceCategory"]),
    subcategory: json["subcategory"],
    priority: json["priority"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    startTime: json["startTime"],
    endTime: json["endTime"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    description: json["description"],
    attachments: json["attachments"] == null ? [] : List<String?>.from(json["attachments"]!.map((x) => x)),
    status: json["status"],
    leadFee: json["leadFee"],
    paymentStatus: json["paymentStatus"],
    completionProof: json["completionProof"] == null ? [] : List<dynamic>.from(json["completionProof"]!.map((x) => x)),
    potentialProviders: json["potentialProviders"] == null ? [] : List<dynamic>.from(json["potentialProviders"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    requestId: json["requestId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerId": customerId?.toJson(),
    "customerPhone": customerPhone,
    "serviceCategory": serviceCategory?.toJson(),
    "subcategory": subcategory,
    "priority": priority,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "startTime": startTime,
    "endTime": endTime,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "description": description,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x)),
    "status": status,
    "leadFee": leadFee,
    "paymentStatus": paymentStatus,
    "completionProof": completionProof == null ? [] : List<dynamic>.from(completionProof!.map((x) => x)),
    "potentialProviders": potentialProviders == null ? [] : List<dynamic>.from(potentialProviders!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "requestId": requestId,
  };
}

class CustomerId {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;

  CustomerId({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
  });

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}

class ServiceCategory {
  final String? id;
  final String? name;
  final String? icon;

  ServiceCategory({
    this.id,
    this.name,
    this.icon,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) => ServiceCategory(
    id: json["_id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "icon": icon,
  };
}
