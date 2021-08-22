
import 'package:oya_porter/pages/Users/model/tripModel.dart';

class TicketsModel {
  int status;
  String message;
  List<Data> data;

  TicketsModel({this.status, this.message, this.data});

  TicketsModel.fromJson(Map<String, dynamic> json) {
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
  String ticketNo;
  String price;
  BusSchedule busSchedule;
  Seat seat;
  String pmtStatus;

  Data({
    this.id,
    this.ticketNo,
    this.price,
    this.busSchedule,
    this.seat,
    this.pmtStatus,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketNo = json['ticket_no'];
    price = json['price'].toString();
    pmtStatus = json['pmt_status'];

    busSchedule = json['bus_schedule'] != null
        ? new BusSchedule.fromJson(json['bus_schedule'])
        : null;
    seat = json['seat'] != null ? new Seat.fromJson(json['seat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_no'] = this.ticketNo;
    data['price'] = this.price;
    data['pmt_status'] = this.price;

    if (this.busSchedule != null) {
      data['bus_schedule'] = this.busSchedule.toJson();
    }
    if (this.seat != null) {
      data['seat'] = this.seat.toJson();
    }
    return data;
  }
}
