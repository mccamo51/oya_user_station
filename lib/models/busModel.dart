class BussModel {
  int status;
  String message;
  List<Data> data;

  BussModel({this.status, this.message, this.data});

  BussModel.fromJson(Map<String, dynamic> json) {
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
  String regNumber;
  String model;
  String rwExpDate;
  String insuranceExpDate;
  String image;
  int driverId;
  String description;
  BusType busType;
  BusCompany busCompany;
  Driver driver;

  Data(
      {this.id,
      this.regNumber,
      this.model,
      this.rwExpDate,
      this.insuranceExpDate,
      this.image,
      this.driverId,
      this.description,
      this.busType,
      this.busCompany,
      this.driver});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regNumber = json['reg_number'];
    model = json['model'];
    rwExpDate = json['rw_exp_date'];
    insuranceExpDate = json['insurance_exp_date'];
    image = json['image'];
    driverId = json['driver_id'];
    description = json['description'];
    busType = json['bus_type'] != null
        ? new BusType.fromJson(json['bus_type'])
        : null;
    busCompany = json['bus_company'] != null
        ? new BusCompany.fromJson(json['bus_company'])
        : null;
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reg_number'] = this.regNumber;
    data['model'] = this.model;
    data['rw_exp_date'] = this.rwExpDate;
    data['insurance_exp_date'] = this.insuranceExpDate;
    data['image'] = this.image;
    data['driver_id'] = this.driverId;
    data['description'] = this.description;
    if (this.busType != null) {
      data['bus_type'] = this.busType.toJson();
    }
    if (this.busCompany != null) {
      data['bus_company'] = this.busCompany.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver.toJson();
    }
    return data;
  }
}

class BusType {
  int id;
  String name;
  int minCapacity;
  int maxCapacity;

  BusType({this.id, this.name, this.minCapacity, this.maxCapacity});

  BusType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minCapacity = json['min_capacity'];
    maxCapacity = json['max_capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min_capacity'] = this.minCapacity;
    data['max_capacity'] = this.maxCapacity;
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

class Driver {
  int id;
  Station station;
  User user;
  CompanyType accountType;

  Driver({this.id, this.station, this.user, this.accountType});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    station =
        json['station'] != null ? new Station.fromJson(json['station']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accountType = json['account_type'] != null
        ? new CompanyType.fromJson(json['account_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.station != null) {
      data['station'] = this.station.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.accountType != null) {
      data['account_type'] = this.accountType.toJson();
    }
    return data;
  }
}

class Station {
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

  Station(
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

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    code = json['code'];
    name = json['name'];
    location = json['location'];
    email = json['email'];
    longitude = json['longitude'].toString();
    latitude = json['latitude'].toString();
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

class User {
  int id;
  String phone;
  String name;
  String email;
  String ice1Phone;
  String ice2Phone;
  String verifiedAt;
  String code;
  String expiration;
  int accountStatus;
  String specialHireCode;

  User(
      {this.id,
      this.phone,
      this.name,
      this.email,
      this.ice1Phone,
      this.ice2Phone,
      this.verifiedAt,
      this.code,
      this.expiration,
      this.accountStatus,
      this.specialHireCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    ice1Phone = json['ice1_phone'];
    ice2Phone = json['ice2_phone'];
    verifiedAt = json['verified_at'];
    code = json['code'];
    expiration = json['expiration'];
    accountStatus = json['account_status'];
    specialHireCode = json['special_hire_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['email'] = this.email;
    data['ice1_phone'] = this.ice1Phone;
    data['ice2_phone'] = this.ice2Phone;
    data['verified_at'] = this.verifiedAt;
    data['code'] = this.code;
    data['expiration'] = this.expiration;
    data['account_status'] = this.accountStatus;
    data['special_hire_code'] = this.specialHireCode;
    return data;
  }
}
