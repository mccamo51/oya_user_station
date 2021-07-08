class ScaledBusModel {
  int status;
  String message;
  List<Data> data;

  ScaledBusModel({this.status, this.message, this.data});

  ScaledBusModel.fromJson(Map<String, dynamic> json) {
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
  int loading;
  int priority;
  int scaled;
  int loaded;
  String loadedTime;
  String arrivalDate;
  String arrivalTime;
  int passengersCount;
  String minors;
  String createdAt;
  List<Staffs> staffs;
  String price;
  String midRoute;
  Bus bus;
  Route route;
  Station station;
  List<Tickets> tickets;

  Data(
      {this.id,
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
      this.loading,
      this.bus,
      this.route,
      this.station,
      this.tickets});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departureDate = json['departure_date'];
    departureTime = json['departure_time'];
    code = json['code'];
    priority = json['priority'];
    scaled = json['scaled'];
    loaded = json['loaded'];
    loading = json['loading'];
    loadedTime = json['loaded_time'];
    arrivalDate = json['arrival_date'];
    arrivalTime = json['arrival_time'];
    passengersCount = json['passengers_count'];
    minors = json['minors'].toString();
    createdAt = json['created_at'];
    if (json['staffs'] != null) {
      staffs = new List<Staffs>();
      json['staffs'].forEach((v) {
        staffs.add(new Staffs.fromJson(v));
      });
    }
    price = json['price'].toString();
    midRoute = json['mid_route'].toString();
    bus = json['bus'] != null ? new Bus.fromJson(json['bus']) : null;
    route = json['route'] != null ? new Route.fromJson(json['route']) : null;
    station =
        json['station'] != null ? new Station.fromJson(json['station']) : null;
    if (json['tickets'] != null) {
      tickets = new List<Tickets>();
      json['tickets'].forEach((v) {
        tickets.add(new Tickets.fromJson(v));
      });
    }
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
    data['loading'] = this.loading;

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
    if (this.tickets != null) {
      data['tickets'] = this.tickets.map((v) => v.toJson()).toList();
    }
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
  String momo;
  String network;
  String name;
  String location;
  String email;
  String longitude;
  String latitude;
  int insurancePolicyId;
  BusCompany busCompany;
  Region region;

  Station(
      {this.id,
      this.phone,
      this.code,
      this.momo,
      this.network,
      this.name,
      this.location,
      this.email,
      this.longitude,
      this.latitude,
      this.insurancePolicyId,
      this.busCompany,
      this.region});

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    code = json['code'];
    momo = json['momo'];
    network = json['network'];
    name = json['name'];
    location = json['location'];
    email = json['email'];
    longitude = json['longitude'].toString();
    latitude = json['latitude'].toString();
    insurancePolicyId = json['insurance_policy_id'];
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
    data['momo'] = this.momo;
    data['network'] = this.network;
    data['name'] = this.name;
    data['location'] = this.location;
    data['email'] = this.email;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['insurance_policy_id'] = this.insurancePolicyId;
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
  String specialHireCode;
  String createdAt;

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
      this.specialHireCode,
      this.createdAt});

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
    createdAt = json['created_at'];
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
    data['created_at'] = this.createdAt;
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
  String latitude;
  String longitude;

  From({this.id, this.name, this.latitude, this.longitude});

  From.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
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

class InsurancePolicy {
  int id;
  String name;
  String price;
  String policyCode;
  int addedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  InsurancePolicy(
      {this.id,
      this.name,
      this.price,
      this.policyCode,
      this.addedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  InsurancePolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toString();
    policyCode = json['policy_code'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['policy_code'] = this.policyCode;
    data['added_by'] = this.addedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Tickets {
  int id;
  int stationId;
  String ticketNo;
  String recipientPhone;
  String reportingDate;
  String reportingTime;
  String pmtStatus;
  String pickupTime;
  String boardingType;
  int status;
  String price;
  String updatedBy;
  String deletedBy;
  int checkedIn;
  List<int> multiTickets;
  String multiType;
  int insuranceId;
  User user;
  Seat seat;
  Pickup pickup;
  BusSchedule busSchedule;

  Tickets(
      {this.id,
      this.stationId,
      this.ticketNo,
      this.recipientPhone,
      this.reportingDate,
      this.reportingTime,
      this.pmtStatus,
      this.pickupTime,
      this.boardingType,
      this.status,
      this.price,
      this.updatedBy,
      this.deletedBy,
      this.checkedIn,
      this.multiTickets,
      this.multiType,
      this.insuranceId,
      this.user,
      this.seat,
      this.pickup,
      this.busSchedule});

  Tickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationId = json['station_id'];
    ticketNo = json['ticket_no'];
    recipientPhone = json['recipient_phone'];
    reportingDate = json['reporting_date'];
    reportingTime = json['reporting_time'];
    pmtStatus = json['pmt_status'];
    pickupTime = json['pickup_time'];
    boardingType = json['boarding_type'];
    status = json['status'];
    price = json['price'].toString();
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    checkedIn = json['checked_in'];
    multiTickets = json['multi_tickets'].cast<int>();
    multiType = json['multi_type'];
    insuranceId = json['insurance_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    seat = json['seat'] != null ? new Seat.fromJson(json['seat']) : null;
    pickup =
        json['pickup'] != null ? new Pickup.fromJson(json['pickup']) : null;
    busSchedule = json['bus_schedule'] != null
        ? new BusSchedule.fromJson(json['bus_schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['station_id'] = this.stationId;
    data['ticket_no'] = this.ticketNo;
    data['recipient_phone'] = this.recipientPhone;
    data['reporting_date'] = this.reportingDate;
    data['reporting_time'] = this.reportingTime;
    data['pmt_status'] = this.pmtStatus;
    data['pickup_time'] = this.pickupTime;
    data['boarding_type'] = this.boardingType;
    data['status'] = this.status;
    data['price'] = this.price;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['checked_in'] = this.checkedIn;
    data['multi_tickets'] = this.multiTickets;
    data['multi_type'] = this.multiType;
    data['insurance_id'] = this.insuranceId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.seat != null) {
      data['seat'] = this.seat.toJson();
    }
    if (this.pickup != null) {
      data['pickup'] = this.pickup.toJson();
    }
    if (this.busSchedule != null) {
      data['bus_schedule'] = this.busSchedule.toJson();
    }
    return data;
  }
}

class Seat {
  int id;
  int status;
  int number;
  String updatedBy;
  String deletedBy;

  Seat({this.id, this.status, this.number, this.updatedBy, this.deletedBy});

  Seat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    number = json['number'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['number'] = this.number;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    return data;
  }
}

class Pickup {
  int id;
  String name;
  String longitude;
  String latitude;
  String location;
  String landmark;
  String url;
  String updatedBy;
  String deletedBy;
  Region region;

  Pickup(
      {this.id,
      this.name,
      this.longitude,
      this.latitude,
      this.location,
      this.landmark,
      this.url,
      this.updatedBy,
      this.deletedBy,
      this.region});

  Pickup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'].toString();
    latitude = json['latitude'].toString();
    location = json['location'];
    landmark = json['landmark'];
    url = json['url'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    region =
        json['region'] != null ? new Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['location'] = this.location;
    data['landmark'] = this.landmark;
    data['url'] = this.url;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    return data;
  }
}

class BusSchedule {
  int id;
  String departureDate;
  String departureTime;
  String arrivalDate;
  String arrivalTime;
  int priority;
  int scaled;
  int loaded;
  int loading;
  String loadedTime;
  int staffId;
  String price;
  int midRoute;
  int ticketing;
  String slug;
  String code;
  String createdAt;
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
      this.createdAt,
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
    price = json['price'].toString();
    midRoute = json['mid_route'];
    ticketing = json['ticketing'];
    slug = json['slug'];
    code = json['code'];
    createdAt = json['created_at'];
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
    data['created_at'] = this.createdAt;
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
