import 'package:flutter/material.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase/firebaseAuth.dart';

FireAuth _fireAuth = new FireAuth();

Future<void> deleteCache(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  await prefs.remove("alltrips");
  await prefs.remove("alltickets");
  await prefs.remove("ticketFrom");
  await prefs.remove("userDetails");
  await prefs.remove('userDetails');
  await prefs.remove("displayName");
  await prefs.remove("email");
  await prefs.remove("photoURL");
  await prefs.remove("uid");
  await prefs.remove("google");
  await _fireAuth.signOut();
  saveBoolShare(key: "auth", data: false);
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false);
}

void callLauncher(String url) async {
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not open, try different text';
  // }
}

double calculateDistance(
    {var cos, var sqrt, var asin, List<dynamic> data, var pow}) {
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  double totalDistance = 0;
  for (var i = 0; i < data.length - 1; i++) {
    totalDistance += calculateDistance(
        data[i]["lat"], data[i]["lng"], data[i + 1]["lat"], data[i + 1]["lng"]);
  }
  return (roundDouble(totalDistance, 2));
}

Future<void> sessionExpired(BuildContext context) async {
  toastContainer(text: "User session expired");
  deleteCache(context);
}
