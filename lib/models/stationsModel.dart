class StationsModel {
  int status;
  String message;
  List<Data> data;

  StationsModel({this.status, this.message, this.data});

  StationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String phone;
  String code;
  String name;
  String location;
  String email;
  String longitude;
  String latitude;
  BusCompany busCompany;
  Region region;

  Data(
      {this.id,
      this.phone,
      this.code,
      this.name,
      this.location,
      this.email,
      this.longitude,
      this.latitude,
      this.busCompany,
      this.region});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    code = json['code'];
    name = json['name'];
    location = json['location'];
    email = json['email'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    busCompany = json['bus_company'] != null
        ? new BusCompany.fromJson(json['bus_company'])
        : null;
    region =
        json['region'] != null ? new Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['code'] = this.code;
    data['name'] = this.name;
    data['location'] = this.location;
    data['email'] = this.email;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    if (this.busCompany != null) {
      data['bus_company'] = this.busCompany.toJson();
    }
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    return data;
  }
}

class BusCompany {
  int id;
  String name;
  String phone;
  String email;
  String logo;
  String contactName;
  String contactPhone;
  int status;
  CompanyType companyType;

  BusCompany(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.logo,
      this.contactName,
      this.contactPhone,
      this.status,
      this.companyType});

  BusCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    logo = json['logo'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    status = json['status'];
    companyType = json['company_type'] != null
        ? new CompanyType.fromJson(json['company_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['logo'] = this.logo;
    data['contact_name'] = this.contactName;
    data['contact_phone'] = this.contactPhone;
    data['status'] = this.status;
    if (this.companyType != null) {
      data['company_type'] = this.companyType.toJson();
    }
    return data;
  }
}

class CompanyType {
  int id;
  String name;

  CompanyType({this.id, this.name});

  CompanyType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Region {
  int id;
  String name;
  String code;

  Region({this.id, this.name, this.code});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
