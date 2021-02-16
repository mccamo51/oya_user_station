class BusTypeModel {
  int status;
  String message;
  List<Data> data;

  BusTypeModel({this.status, this.message, this.data});

  BusTypeModel.fromJson(Map<String, dynamic> json) {
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
  int minCapacity;
  int maxCapacity;
  int buses;

  Data({this.id, this.name, this.minCapacity, this.maxCapacity, this.buses});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minCapacity = json['min_capacity'];
    maxCapacity = json['max_capacity'];
    buses = json['buses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min_capacity'] = this.minCapacity;
    data['max_capacity'] = this.maxCapacity;
    data['buses'] = this.buses;
    return data;
  }
}
