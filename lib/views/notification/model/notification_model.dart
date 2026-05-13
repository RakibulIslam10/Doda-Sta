class NotificationModel {
  final num? statusCode;
  final bool? success;
  final String? message;
  final Data? data;

  NotificationModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
  final List<NotificationItem>? notification;

  Data({
    this.notification,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notification: json["notification"] == null ? [] : List<NotificationItem>.from(json["notification"]!.map((x) => NotificationItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notification": notification == null ? [] : List<dynamic>.from(notification!.map((x) => x.toJson())),
  };
}

class NotificationItem {
  final String? id;
  final String? title;
  final String? message;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationItem({
    this.id,
    this.title,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json["_id"],
    title: json["title"],
    message: json["message"],
    isRead: json["isRead"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "message": message,
    "isRead": isRead,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
