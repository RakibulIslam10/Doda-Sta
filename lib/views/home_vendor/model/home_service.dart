class HomeServiceItem {
  String? id;
  String? requestId;
  String? subcategory;
  ServiceCategory? serviceCategory;
  String? address;
  List<Attachment>? attachments;
  String? customerPhone;
  CustomerId? customerId;
  String? priority;
  String? description;

  HomeServiceItem({
    this.id,
    this.requestId,
    this.subcategory,
    this.serviceCategory,
    this.address,
    this.attachments,
    this.customerPhone,
    this.customerId,
    this.priority,
    this.description,
  });

  HomeServiceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    subcategory = json['subcategory'];
    serviceCategory = json['serviceCategory'] != null
        ? ServiceCategory.fromJson(json['serviceCategory'])
        : null;
    address = json['address'];
    if (json['attachments'] != null) {
      attachments = <Attachment>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachment.fromJson(v));
      });
    }
    customerPhone = json['customerPhone'];
    customerId = json['customerId'] != null
        ? CustomerId.fromJson(json['customerId'])
        : null;
    priority = json['priority'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['requestId'] = requestId;
    data['subcategory'] = subcategory;
    if (serviceCategory != null) {
      data['serviceCategory'] = serviceCategory!.toJson();
    }
    data['address'] = address;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['customerPhone'] = customerPhone;
    if (customerId != null) {
      data['customerId'] = customerId!.toJson();
    }
    data['priority'] = priority;
    data['description'] = description;
    return data;
  }
}

class ServiceCategory {
  String? name;
  String? icon;

  ServiceCategory({this.name, this.icon});

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}

class Attachment {
  String? url;
  String? type;
  String? id;

  Attachment({this.url, this.type, this.id});

  Attachment.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}

class CustomerId {
  String? name;
  String? email;
  String? phone;

  CustomerId({this.name, this.email, this.phone});

  CustomerId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}