class PassengerRangeModel {
  int status;
  String message;
  List<Data> data;

  PassengerRangeModel({this.status, this.message, this.data});

  PassengerRangeModel.fromJson(Map<String, dynamic> json) {
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
  int min;
  int max;

  Data({this.id, this.min, this.max});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}
