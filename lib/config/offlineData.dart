import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Map<String, dynamic> allStaffMapOffline;
// Future<void> loadAllStaffOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allStaff")) {
//     String encodeData = prefs.getString("allStaff");
//     // print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     allStaffMapOffline = decodeData;
//   } else
//     allStaffMapOffline = null;
// }

// Map<String, dynamic> alBussesMapOffline;
// Future<void> loadallAllBussesOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allBusses")) {
//     String encodeData = prefs.getString("allBusses");
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     alBussesMapOffline = decodeData;
//   } else
//     alBussesMapOffline = null;
// }

// Map<String, dynamic> allRatingMapOffline;
// Future<void> loadAllRatingOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allrating")) {
//     String encodeData = prefs.getString("allrating");
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     allRatingMapOffline = decodeData;
//   } else
//     allRatingMapOffline = null;
// }

Map<String, dynamic> schedulesMapOffline;
Future<void> loadallSchedulesOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("allschedule")) {
    String encodeData = prefs.getString("allschedule");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    schedulesMapOffline = decodeData;
  } else
    schedulesMapOffline = null;
}

Map<String, dynamic> pickupsMapOffline;
Future<void> loadallSchedulePickupsOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("schedulepickups")) {
    String encodeData = prefs.getString("schedulepickups");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    pickupsMapOffline = decodeData;
  } else
    pickupsMapOffline = null;
}

Map<String, dynamic> ticketMapOffline;
Future<void> loadallTicketsOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("allticket")) {
    String encodeData = prefs.getString("allticket");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    ticketMapOffline = decodeData;
  } else
    ticketMapOffline = null;
}

Map<String, dynamic> myRouteMapOffline;
Future<void> loadMyRouteOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("myroute")) {
    String encodeData = prefs.getString("myroute");
    // print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    myRouteMapOffline = decodeData;
  } else
    myRouteMapOffline = null;
}

Map<String, dynamic> driversMapOffline;
Future<void> loadDriverOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("drivers")) {
    String encodeData = prefs.getString("drivers");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    driversMapOffline = decodeData;
  } else
    driversMapOffline = null;
}

Map<String, dynamic> busTypeModelMapOffline;
Future<void> loadBusTypeModelOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("bustype")) {
    String encodeData = prefs.getString("bustype");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    busTypeModelMapOffline = decodeData;
  } else
    busTypeModelMapOffline = null;
}

// Map<String, dynamic> regionMapOffline;
// Future<void> loadregionOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("regions")) {
//     String encodeData = prefs.getString("regions");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     regionMapOffline = decodeData;
//   } else
//     regionMapOffline = null;
// }

// Map<String, dynamic> townMapOffline;
// Future<void> loadTownOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("towns")) {
//     String encodeData = prefs.getString("towns");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     townMapOffline = decodeData;
//   } else
//     townMapOffline = null;
// }

Map<String, dynamic> conductorsMapOffline;
Future<void> loadconductorsOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("conductors")) {
    String encodeData = prefs.getString("conductors");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    conductorsMapOffline = decodeData;
  } else
    conductorsMapOffline = null;
}

Map<String, dynamic> portersMapOffline;
Future<void> loadportersOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("porters")) {
    String encodeData = prefs.getString("porters");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    portersMapOffline = decodeData;
  } else
    portersMapOffline = null;
}

Map<String, dynamic> busesMapOffline;
Future<void> loadbusesOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("allBusses")) {
    String encodeData = prefs.getString("allBusses");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    busesMapOffline = decodeData;
  } else
    busesMapOffline = null;
}

// Map<String, dynamic> reportMapOffline;
// Future<void> loadReportOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("speed_reports")) {
//     String encodeData = prefs.getString("speed_reports");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     reportMapOffline = decodeData;
//   } else
//     reportMapOffline = null;
// }

Map<String, dynamic> loadedbusesMapOffline;
Future<void> loadLoadedBusOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("loaded_buses")) {
    String encodeData = prefs.getString("loaded_buses");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    loadedbusesMapOffline = decodeData;
  } else
    loadedbusesMapOffline = null;
}

Map<String, dynamic> scaledBusMapOffline;
Future<void> loadScaledBusOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("scaled_buses")) {
    String encodeData = prefs.getString("scaled_buses");
    // print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    scaledBusMapOffline = decodeData;
  } else
    scaledBusMapOffline = null;
}

// Map<String, dynamic> priorityBusMapOffline;
// Future<void> loadPriorityBusOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("priority_buses")) {
//     String encodeData = prefs.getString("priority_buses");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     priorityBusMapOffline = decodeData;
//   } else
//     priorityBusMapOffline = null;
// }

Map<String, dynamic> stationsMapOffline;
Future<void> loadStationsOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("stations")) {
    String encodeData = prefs.getString("stations");
    print(encodeData);
    Map<String, dynamic> decodeData = json.decode(encodeData);
    stationsMapOffline = decodeData;
  } else
    stationsMapOffline = null;
}

// Map<String, dynamic> loadParcelSentMapOffline;
// Future<void> loadParcelSentOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("parcelByPorter")) {
//     String encodeData = prefs.getString("parcelByPorter");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     loadParcelSentMapOffline = decodeData;
//   } else
//     loadParcelSentMapOffline = null;
// }

// Map<String, dynamic> loadParcelRecievedMapOffline;
// Future<void> loadParcelRecievedOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("parcelRecieved")) {
//     String encodeData = prefs.getString("parcelRecieved");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     loadParcelRecievedMapOffline = decodeData;
//   } else
//     loadParcelRecievedMapOffline = null;
// }

// Map<String, dynamic> loadTownsByRegMapOffline;
// Future<void> loadTownsByRegOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("townByRegion")) {
//     String encodeData = prefs.getString("townByRegion");
//     // print(encodeData);all
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     loadParcelRecievedMapOffline = decodeData;
//   } else
//     loadParcelRecievedMapOffline = null;
// }

// Map<String, dynamic> loadScheduledBusesMapOffline;
// Future<void> loadScheduledBusesOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("scheduledbuses")) {
//     String encodeData = prefs.getString("scheduledbuses");
//     // print(encodeData);all
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     loadParcelRecievedMapOffline = decodeData;
//   } else
//     loadParcelRecievedMapOffline = null;
// }
