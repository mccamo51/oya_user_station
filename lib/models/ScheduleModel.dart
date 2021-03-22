class ScheduleModel {
  int status;
  String message;
  List<Data> data;

  ScheduleModel({this.status, this.message, this.data});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
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
  String departureDate;
  String departureTime;
  String code;
  int priority;
  int scaled;
  int loaded;
  String loadedTime;
  String arrivalDate;
  String arrivalTime;
  int passengersCount;
  int minors;
  String createdAt;
  List<Staffs> staffs;
  String price;
  int midRoute;
  Bus bus;
  Route route;
  Station station;
  // List<Null> tickets;

  Data({
    this.id,
    this.departureDate,
    this.departureTime,
    this.code,
    this.priority,
    this.scaled,
    this.loaded,
    this.loadedTime,
    this.arrivalDate,
    this.arrivalTime,
    this.passengersCount,
    this.minors,
    this.createdAt,
    this.staffs,
    this.price,
    this.midRoute,
    this.bus,
    this.route,
    this.station,
    // this.tickets,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departureDate = json['departure_date'];
    departureTime = json['departure_time'];
    code = json['code'];
    priority = json['priority'];
    scaled = json['scaled'];
    loaded = json['loaded'];
    loadedTime = json['loaded_time'];
    arrivalDate = json['arrival_date'];
    arrivalTime = json['arrival_time'];
    passengersCount = json['passengers_count'];
    minors = json['minors'];
    createdAt = json['created_at'];
    if (json['staffs'] != null) {
      staffs = new List<Staffs>();
      json['staffs'].forEach((v) {
        staffs.add(new Staffs.fromJson(v));
      });
    }
    price = json['price'].toString();
    midRoute = json['mid_route'];
    bus = json['bus'] != null ? new Bus.fromJson(json['bus']) : null;
    route = json['route'] != null ? new Route.fromJson(json['route']) : null;
    station =
        json['station'] != null ? new Station.fromJson(json['station']) : null;
    // if (json['tickets'] != null) {
    //   tickets = new List<Null>();
    //   json['tickets'].forEach((v) {
    //     tickets.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['departure_date'] = this.departureDate;
    data['departure_time'] = this.departureTime;
    data['code'] = this.code;
    data['priority'] = this.priority;
    data['scaled'] = this.scaled;
    data['loaded'] = this.loaded;
    data['loaded_time'] = this.loadedTime;
    data['arrival_date'] = this.arrivalDate;
    data['arrival_time'] = this.arrivalTime;
    data['passengers_count'] = this.passengersCount;
    data['minors'] = this.minors;
    data['created_at'] = this.createdAt;
    if (this.staffs != null) {
      data['staffs'] = this.staffs.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['mid_route'] = this.midRoute;
    if (this.bus != null) {
      data['bus'] = this.bus.toJson();
    }
    if (this.route != null) {
      data['route'] = this.route.toJson();
    }
    if (this.station != null) {
      data['station'] = this.station.toJson();
    }
    // if (this.tickets != null) {
    //   data['tickets'] = this.tickets.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Staffs {
  String name;
  String phone;
  String role;

  Staffs({this.name, this.phone, this.role});

  Staffs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    return data;
  }
}

class Bus {
  int id;
  String regNumber;
  Driver driver;
  String model;
  String rwExpDate;
  String insuranceExpDate;
  BusType busType;

  Bus(
      {this.id,
      this.regNumber,
      this.driver,
      this.model,
      this.rwExpDate,
      this.insuranceExpDate,
      this.busType});

  Bus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regNumber = json['reg_number'];
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    model = json['model'];
    rwExpDate = json['rw_exp_date'];
    insuranceExpDate = json['insurance_exp_date'];
    busType = json['bus_type'] != null
        ? new BusType.fromJson(json['bus_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reg_number'] = this.regNumber;
    if (this.driver != null) {
      data['driver'] = this.driver.toJson();
    }
    data['model'] = this.model;
    data['rw_exp_date'] = this.rwExpDate;
    data['insurance_exp_date'] = this.insuranceExpDate;
    if (this.busType != null) {
      data['bus_type'] = this.busType.toJson();
    }
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
  int specialHireCode;

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

class Route {
  int id;
  From from;
  From to;

  Route({this.id, this.from, this.to});

  Route.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.from != null) {
      data['from'] = this.from.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to.toJson();
    }
    return data;
  }
}

class From {
  int id;
  String name;
  double latitude;
  double longitude;

  From({this.id, this.name, this.latitude, this.longitude});

  From.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
