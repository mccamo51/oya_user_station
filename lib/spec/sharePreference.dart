import 'package:flutter/material.dart';
import 'package:oya_porter/config/firebase/firebaseAuth.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


FireAuth _fireAuth = new FireAuth();
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
  saveStringShare(key: "userDetails", data: "");
  await preferences.remove('userDetails');
  await preferences.remove("userDetails");
  await preferences.remove("stationId");
  await preferences.remove("accessToken");
  await preferences.remove("firebaseUserId");
  await preferences.remove("uid");
  await preferences.remove("google");
  await _fireAuth.signOut();
  saveBoolShare(key: "auth", data: false);
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false);
}
