// import 'package:flutter/material.dart';
// import 'package:oya_mobile/screens/auth/login/login.dart';
// import 'package:oya_mobile/spec/sharePreference.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// deleteCache(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.clear();
//   await prefs.remove("alltrips");
//   await prefs.remove("alltickets");
//   await prefs.remove("ticketFrom");
//   await prefs.remove("userDetails");
//   await prefs.remove('userDetails');
//   await prefs.remove("displayName");
//   await prefs.remove("email");
//   await prefs.remove("photoURL");
//   await prefs.remove("uid");
//   await prefs.remove("google");
//   saveBoolShare(key: "auth", data: false);
//   Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginPage()),
//       (Route<dynamic> route) => false);
// }

// double calculateDistance(
//     {var cos, var sqrt, var asin, List<dynamic> data, var pow}) {
//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   double roundDouble(double value, int places) {
//     double mod = pow(10.0, places);
//     return ((value * mod).round().toDouble() / mod);
//   }

//   // List<dynamic> data = [
//   //   {
//   //     "lat": 44.968046,
//   //     "lng": -94.420307
//   //   },{
//   //     "lat": 44.33328,
//   //     "lng": -89.132008
//   //   },{
//   //     "lat": 33.755787,
//   //     "lng": -116.359998
//   //   },{
//   //     "lat": 33.844843,
//   //     "lng": -116.54911
//   //   },{
//   //     "lat": 44.92057,
//   //     "lng": -93.44786
//   //   },{
//   //     "lat": 44.240309,
//   //     "lng": -91.493619
//   //   },{
//   //     "lat": 44.968041,
//   //     "lng": -94.419696
//   //   },{
//   //     "lat": 44.333304,
//   //     "lng": -89.132027
//   //   },{
//   //     "lat": 33.755783,
//   //     "lng": -116.360066
//   //   },{
//   //     "lat": 33.844847,
//   //     "lng": -116.549069
//   //   },
//   // ];
//   double totalDistance = 0;
//   for (var i = 0; i < data.length - 1; i++) {
//     totalDistance += calculateDistance(
//         data[i]["lat"], data[i]["lng"], data[i + 1]["lat"], data[i + 1]["lng"]);
//   }
//   return (roundDouble(totalDistance, 2));
// }
