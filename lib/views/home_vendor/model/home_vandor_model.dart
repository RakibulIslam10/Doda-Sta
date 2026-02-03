import '../../home/model/home_model.dart';

class VandorHomeModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  VandorHomeModel({this.statusCode, this.success, this.message, this.data});

  VandorHomeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  Meta? meta;
  List<HomeServiceItem>? requests;

  Data({this.meta, this.requests});

  Data.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['requests'] != null) {
      requests = <HomeServiceItem>[];
      json['requests'].forEach((v) {
        requests!.add(HomeServiceItem.fromJson(v));
      });
    }
  }

}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Meta({this.page, this.limit, this.total, this.totalPages});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPages'] = totalPages;
    return data;
  }
}