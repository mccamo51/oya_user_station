class PickupPointModel {
  int status;
  String message;
  List<Data> data;

  PickupPointModel({this.status, this.message, this.data});

  PickupPointModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  double longitude;
  double latitude;
  String location;
  String landmark;
  String url;
  String updatedBy;
  String deletedBy;
  Region region;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
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
