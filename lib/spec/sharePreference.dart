import 'package:flutter/material.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

//saving
saveBoolShare({@required String key, @required var data}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, data);
}

saveStringShare({@required String key, @required var data}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, data);
}

//getting
Future<bool> getShareAuthData() async {
  bool ret;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("auth")) {
    ret = prefs.getBool("auth");
  } else {
    saveBoolShare(key: "auth", data: false);
    ret = prefs.getBool("auth");
  }
  return ret;
}

clearUser(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  saveBoolShare(key: "auth", data: false);
  saveStringShare(key: "userDetails", data: "");
  await preferences.remove('userDetails');
  await preferences.remove("userDetails");
  await preferences.remove("stationId");
  await preferences.remove("accessToken");
  await preferences.remove("uid");
  await preferences.remove("google");
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false);
}
