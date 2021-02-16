class AllRouteModel {
  int status;
  String message;
  List<Data> data;

  AllRouteModel({this.status, this.message, this.data});

  AllRouteModel.fromJson(Map<String, dynamic> json) {
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
  double rating;
  String feedback;
  String createdAt;
  int routeId;
  int stationId;
  int busId;
  int driverId;
  int conductorId;
  int porterId;
  String departureDate;
  String departureTime;
  Null arrivalDate;
  Null arrivalTime;
  int priority;
  int scaled;
  int loaded;
  int loading;
  Null loadedTime;
  int staffId;
  Null updatedBy;
  Null deletedBy;
  double price;
  int midRoute;
  int ticketing;
  String slug;
  String code;
  User user;
  BusSchedule busSchedule;

  Data(
      {this.id,
      this.rating,
      this.feedback,
      this.createdAt,
      this.routeId,
      this.stationId,
      this.busId,
      this.driverId,
      this.conductorId,
      this.porterId,
      this.departureDate,
      this.departureTime,
      this.arrivalDate,
      this.arrivalTime,
      this.priority,
      this.scaled,
      this.loaded,
      this.loading,
      this.loadedTime,
      this.staffId,
      this.updatedBy,
      this.deletedBy,
      this.price,
      this.midRoute,
      this.ticketing,
      this.slug,
      this.code,
      this.user,
      this.busSchedule});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    feedback = json['feedback'];
    createdAt = json['created_at'];
    routeId = json['route_id'];
    stationId = json['station_id'];
    busId = json['bus_id'];
    driverId = json['driver_id'];
    conductorId = json['conductor_id'];
    porterId = json['porter_id'];
    departureDate = json['departure_date'];
    departureTime = json['departure_time'];
    arrivalDate = json['arrival_date'];
    arrivalTime = json['arrival_time'];
    priority = json['priority'];
    scaled = json['scaled'];
    loaded = json['loaded'];
    loading = json['loading'];
    loadedTime = json['loaded_time'];
    staffId = json['staff_id'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    price = json['price'];
    midRoute = json['mid_route'];
    ticketing = json['ticketing'];
    slug = json['slug'];
    code = json['code'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    busSchedule = json['bus_schedule'] != null
        ? new BusSchedule.fromJson(json['bus_schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    data['created_at'] = this.createdAt;
    data['route_id'] = this.routeId;
    data['station_id'] = this.stationId;
    data['bus_id'] = this.busId;
    data['driver_id'] = this.driverId;
    data['conductor_id'] = this.conductorId;
    data['porter_id'] = this.porterId;
    data['departure_date'] = this.departureDate;
    data['departure_time'] = this.departureTime;
    data['arrival_date'] = this.arrivalDate;
    data['arrival_time'] = this.arrivalTime;
    data['priority'] = this.priority;
    data['scaled'] = this.scaled;
    data['loaded'] = this.loaded;
    data['loading'] = this.loading;
    data['loaded_time'] = this.loadedTime;
    data['staff_id'] = this.staffId;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['price'] = this.price;
    data['mid_route'] = this.midRoute;
    data['ticketing'] = this.ticketing;
    data['slug'] = this.slug;
    data['code'] = this.code;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.busSchedule != null) {
      data['bus_schedule'] = this.busSchedule.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String phone;
  String name;
  Null email;
  String ice1Phone;
  String ice2Phone;
  String verifiedAt;
  String code;
  String expiration;
  int accountStatus;
  Null specialHireCode;

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

class BusSchedule {
  int id;
  String departureDate;
  String departureTime;
  Null arrivalDate;
  Null arrivalTime;
  int priority;
  int scaled;
  int loaded;
  int loading;
  Null loadedTime;
  int staffId;
  double price;
  int midRoute;
  int ticketing;
  String slug;
  String code;
  Route route;
  Bus bus;
  Station station;
  Driver driver;
  Driver porter;
  Driver conductor;

  BusSchedule(
      {this.id,
      this.departureDate,
      this.departureTime,
      this.arrivalDate,
      this.arrivalTime,
      this.priority,
      this.scaled,
      this.loaded,
      this.loading,
      this.loadedTime,
      this.staffId,
      this.price,
      this.midRoute,
      this.ticketing,
      this.slug,
      this.code,
      this.route,
      this.bus,
      this.station,
      this.driver,
      this.porter,
      this.conductor});

  BusSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departureDate = json['departure_date'];
    departureTime = json['departure_time'];
    arrivalDate = json['arrival_date'];
    arrivalTime = json['arrival_time'];
    priority = json['priority'];
    scaled = json['scaled'];
    loaded = json['loaded'];
    loading = json['loading'];
    loadedTime = json['loaded_time'];
    staffId = json['staff_id'];
    price = json['price'];
    midRoute = json['mid_route'];
    ticketing = json['ticketing'];
    slug = json['slug'];
    code = json['code'];
    route = json['route'] != null ? new Route.fromJson(json['route']) : null;
    bus = json['bus'] != null ? new Bus.fromJson(json['bus']) : null;
    station =
        json['station'] != null ? new Station.fromJson(json['station']) : null;
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    porter =
        json['porter'] != null ? new Driver.fromJson(json['porter']) : null;
    conductor = json['conductor'] != null
        ? new Driver.fromJson(json['conductor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['departure_date'] = this.departureDate;
    data['departure_time'] = this.departureTime;
    data['arrival_date'] = this.arrivalDate;
    data['arrival_time'] = this.arrivalTime;
    data['priority'] = this.priority;
    data['scaled'] = this.scaled;
    data['loaded'] = this.loaded;
    data['loading'] = this.loading;
    data['loaded_time'] = this.loadedTime;
    data['staff_id'] = this.staffId;
    data['price'] = this.price;
    data['mid_route'] = this.midRoute;
    data['ticketing'] = this.ticketing;
    data['slug'] = this.slug;
    data['code'] = this.code;
    if (this.route != null) {
      data['route'] = this.route.toJson();
    }
    if (this.bus != null) {
      data['bus'] = this.bus.toJson();
    }
    if (this.station != null) {
      data['station'] = this.station.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver.toJson();
    }
    if (this.porter != null) {
      data['porter'] = this.porter.toJson();
    }
    if (this.conductor != null) {
      data['conductor'] = this.conductor.toJson();
    }
    return data;
  }
}

class Route {
  int id;
  int regionId;
  int source;
  int destination;
  Null updatedBy;
  Null deletedBy;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  From from;
  From to;

  Route(
      {this.id,
      this.regionId,
      this.source,
      this.destination,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.from,
      this.to});

  Route.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionId = json['region_id'];
    source = json['source'];
    destination = json['destination'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region_id'] = this.regionId;
    data['source'] = this.source;
    data['destination'] = this.destination;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
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

class Bus {
  int id;
  String regNumber;
  String model;
  String rwExpDate;
  String insuranceExpDate;
  Null image;
  int driverId;
  Null description;
  BusType busType;
  BusCompany busCompany;
  Driver driver;

  Bus(
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

  Bus.fromJson(Map<String, dynamic> json) {
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
  Null logo;
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
  Null longitude;
  Null latitude;
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
