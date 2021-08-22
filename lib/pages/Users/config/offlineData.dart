import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> ticketFromMapOffline;
Future<void> loadTicketFromOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("ticketFrom")) {
    String encodeData = prefs.getString("ticketFrom");
    Map<String, dynamic> decodeData = json.decode(encodeData);
    ticketFromMapOffline = decodeData;
  } else
    ticketFromMapOffline = null;
}

Map<String, dynamic> allTripsMapOffline;
Future<void> loadallAllTripsOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("alltrips")) {
    String encodeData = prefs.getString("alltrips");
    Map<String, dynamic> decodeData = json.decode(encodeData);
    allTripsMapOffline = decodeData;
  } else
    allTripsMapOffline = null;
}

Map<String, dynamic> allTicketsMapOffline;
Future<void> loadallAllTicketsOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("alltickets")) {
    String encodeData = prefs.getString("alltickets");
    Map<String, dynamic> decodeData = json.decode(encodeData);
    allTicketsMapOffline = decodeData;
  } else
    allTicketsMapOffline = null;
}

Map<String, dynamic> congregationMapOffline;
Future<void> loadCongregationOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("special_destinations")) {
    String encodeData = prefs.getString("special_destinations");
    Map<String, dynamic> decodeData = json.decode(encodeData);
    congregationMapOffline = decodeData;
  } else
    congregationMapOffline = null;
}

Map<String, dynamic> featureMapOffline;
Future<void> loadalFeatures() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("features")) {
    String encodeData = prefs.getString("features");
    Map<String, dynamic> decodeData = json.decode(encodeData);
    featureMapOffline = decodeData;
  } else
    featureMapOffline = null;
}

Map<String, dynamic> specialHireMapOffline;
Future<void> loadallSpecialHireOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("special_hirings")) {
    String encodeData = prefs.getString("special_hirings");
    Map<String, dynamic> decodeData = json.decode(encodeData);
    specialHireMapOffline = decodeData;
  } else
    specialHireMapOffline = null;
}


Map<String, dynamic> loadParcelSentMapOffline;
Future<void> loadParcelSentOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("parcelByPorter")) {
    String encodeData = prefs.getString("parcelByPorter");
    Map<String, dynamic> decodeData = json.decode(encodeData);
    loadParcelSentMapOffline = decodeData;
  } else
    loadParcelSentMapOffline = null;
}


Map<String, dynamic> loadParcelRecievedMapOffline;
Future<void> loadParcelRecievedOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("parcelRecieved")) {
    String encodeData = prefs.getString("parcelRecieved");
    Map<String, dynamic> decodeData = json.decode(encodeData);
    loadParcelRecievedMapOffline = decodeData;
  } else
    loadParcelRecievedMapOffline = null;
}
// Map<String, dynamic> bussesMakeMapOffline;
// Future<void> loadallBusMakeOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allBussesMake")) {
//     String encodeData = prefs.getString("allBussesMake");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     bussesMakeMapOffline = decodeData;
//   } else
//     bussesMakeMapOffline = null;
// }

// Map<String, dynamic> bussesModelMapOffline;
// Future<void> loadallBusModelOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allCarBrand")) {
//     String encodeData = prefs.getString("allCarBrand");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     bussesModelMapOffline = decodeData;
//   } else
//     bussesModelMapOffline = null;
// }

// Map<String, dynamic> heavyDutyMapOffline;
// Future<void> loadallHeavyDutyOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allHeavyEquip")) {
//     String encodeData = prefs.getString("allHeavyEquip");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     heavyDutyMapOffline = decodeData;
//   } else
//     heavyDutyMapOffline = null;
// }

// Map<String, dynamic> tractorMapOffline;
// Future<void> loadallTractorOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allTrucks")) {
//     String encodeData = prefs.getString("allTrucks");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     tractorMapOffline = decodeData;
//   } else
//     tractorMapOffline = null;
// }
