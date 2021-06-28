import 'package:flutter/foundation.dart';

class CheckInModel {
  List<Data> data;

  CheckInModel({this.data});

  CheckInModel.fromJson(Map<dynamic, dynamic> json) {
    if (json != null) {
      List<Data> data = new List<Data>();
      json.forEach((key, value) {
        data.add(new Data.fromJson(json: value, key: key));
      });

      if (data != null) {
        data.sort((a, b) {
          return b.timeStamp.compareTo(a.timeStamp);
        });
        this.data = data;
      }
    }
  }
}

class Data {
  String key;
  String busSchecduleId;
  String destination;
  String id;
  String phone;
  String porterId;
  int price;
  String stationId;
  String stationName;
  dynamic timeStamp;
  dynamic read;

  Data({
    this.busSchecduleId,
    this.destination,
    this.id,
    this.phone,
    this.porterId,
    this.price,
    this.stationId,
    this.stationName,
    this.key,
    this.timeStamp,
    this.read,
  });

  Data.fromJson({@required Map<dynamic, dynamic> json, @required String key}) {
    busSchecduleId = json['busSchecduleId'];
    destination = json['destination'];
    id = json['id'];
    phone = json['phone'];
    porterId = json['porterId'];
    price = json['price'];
    stationId = json['stationId'];
    stationName = json['stationName'];
    timeStamp = json['timestamp'];
    read = json['read'];
    this.key = key;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busSchecduleId'] = this.busSchecduleId;
    data['destination'] = this.destination;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['porterId'] = this.porterId;
    data['price'] = this.price;
    data['stationId'] = this.stationId;
    data['stationName'] = this.stationName;
    data['read'] = this.read;
    return data;
  }
}

var checkInModel = CheckInModel();
