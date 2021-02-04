import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> ticketFromMapOffline;
Future<void> loadTicketFromOffline() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("ticketFrom")) {
    String encodeData = prefs.getString("ticketFrom");
    print(encodeData);
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

// Map<String, dynamic> subCategoriesMapOffline;
// Future<void> loadallSubCategoriesOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allsubCategories")) {
//     String encodeData = prefs.getString("allsubCategories");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     subCategoriesMapOffline = decodeData;
//   } else
//     subCategoriesMapOffline = null;
// }

// Map<String, dynamic> carMakeMapOffline;
// Future<void> loadallCarMakeOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allCarsMake")) {
//     String encodeData = prefs.getString("allCarsMake");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     carMakeMapOffline = decodeData;
//   } else
//     carMakeMapOffline = null;
// }

// Map<String, dynamic> carModleMapOffline;
// Future<void> loadallCarModelOffline() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("allCarBrand")) {
//     String encodeData = prefs.getString("allCarBrand");
//     print(encodeData);
//     Map<String, dynamic> decodeData = json.decode(encodeData);
//     carModleMapOffline = decodeData;
//   } else
//     carModleMapOffline = null;
// }

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
