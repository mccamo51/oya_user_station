import 'package:flutter/material.dart';
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

clearUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove('userDetails');
  await preferences.remove("displayName");
  await preferences.remove("email");
  await preferences.remove("photoURL");
  await preferences.remove("uid");
  await preferences.remove("google");
}
