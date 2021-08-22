class SpecialHiringModel {
  int status;
  String message;
  List<Data> data;

  SpecialHiringModel({this.status, this.message, this.data});

  SpecialHiringModel.fromJson(Map<String, dynamic> json) {
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
  String secondaryName;
  String secondaryPhone;
  String pickupDate;
  String pickupTime;
  String returnDate;
  String returnTime;
  int passengers;
  String purpose;
  int numberOfDays;
  List<SelectedFeatures> selectedFeatures;
  int numberOfBuses;
  String price;
  int discount;
  String paymentStatus;
  String amountPaid;
  int balanceDue;
  String referenceCode;
  String paymentDueDate;
  String paymentType;
  String createdAt;
  Congregation congregation;
  SpecialDestination specialDestination;
  User user;

  Data(
      {this.id,
      this.secondaryName,
      this.secondaryPhone,
      this.pickupDate,
      this.pickupTime,
      this.returnDate,
      this.returnTime,
      this.passengers,
      this.purpose,
      this.numberOfDays,
      this.selectedFeatures,
      this.numberOfBuses,
      this.price,
      this.discount,
      this.paymentStatus,
      this.amountPaid,
      this.balanceDue,
      this.referenceCode,
      this.paymentDueDate,
      this.paymentType,
      this.createdAt,
      this.congregation,
      this.specialDestination,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    secondaryName = json['secondary_name'];
    secondaryPhone = json['secondary_phone'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    returnDate = json['return_date'];
    returnTime = json['return_time'];
    passengers = json['passengers'];
    purpose = json['purpose'];
    numberOfDays = json['number_of_days'];
    if (json['selected_features'] != null) {
      selectedFeatures = new List<SelectedFeatures>();
      json['selected_features'].forEach((v) {
        selectedFeatures.add(new SelectedFeatures.fromJson(v));
      });
    }
    numberOfBuses = json['number_of_buses'];
    price = json['price'].toString();
    discount = json['discount'];
    paymentStatus = json['payment_status'];
    amountPaid = json['amount_paid'].toString();
    balanceDue = json['balance_due'];
    referenceCode = json['reference_code'];
    paymentDueDate = json['payment_due_date'];
    paymentType = json['payment_type'];
    createdAt = json['created_at'];
    congregation = json['congregation'] != null
        ? new Congregation.fromJson(json['congregation'])
        : null;
    specialDestination = json['special_destination'] != null
        ? new SpecialDestination.fromJson(json['special_destination'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['secondary_name'] = this.secondaryName;
    data['secondary_phone'] = this.secondaryPhone;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['return_date'] = this.returnDate;
    data['return_time'] = this.returnTime;
    data['passengers'] = this.passengers;
    data['purpose'] = this.purpose;
    data['number_of_days'] = this.numberOfDays;
    if (this.selectedFeatures != null) {
      data['selected_features'] =
          this.selectedFeatures.map((v) => v.toJson()).toList();
    }
    data['number_of_buses'] = this.numberOfBuses;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['payment_status'] = this.paymentStatus;
    data['amount_paid'] = this.amountPaid;
    data['balance_due'] = this.balanceDue;
    data['reference_code'] = this.referenceCode;
    data['payment_due_date'] = this.paymentDueDate;
    data['payment_type'] = this.paymentType;
    data['created_at'] = this.createdAt;
    if (this.congregation != null) {
      data['congregation'] = this.congregation.toJson();
    }
    if (this.specialDestination != null) {
      data['special_destination'] = this.specialDestination.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class SelectedFeatures {
  int id;
  String name;

  SelectedFeatures({this.id, this.name});

  SelectedFeatures.fromJson(Map<String, dynamic> json) {
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

class Congregation {
  int id;
  String name;
  String phone;
  String latitude;
  String longitude;
  String landmark;

  Congregation(
      {this.id,
      this.name,
      this.phone,
      this.latitude,
      this.longitude,
      this.landmark});

  Congregation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['landmark'] = this.landmark;
    return data;
  }
}

class SpecialDestination {
  int id;
  String name;
  String latitude;
  String longitude;
  String landmark;

  SpecialDestination(
      {this.id, this.name, this.latitude, this.longitude, this.landmark});

  SpecialDestination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['landmark'] = this.landmark;
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
