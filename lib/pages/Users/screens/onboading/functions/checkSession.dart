import 'dart:convert';

import 'package:oya_porter/pages/Users/screens/auth/register/secureAccount/secure.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> checkSession() async {
  String auth = "not auth";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("auth")) {
    if (prefs.getBool("auth")) {
      // saveBoolShare(key: "auth", data: false);
      auth = "auth";
    } else {
      if (prefs.containsKey("otpPage")) {
        if (!prefs.getBool("otpPage")) {
          auth = "otp";
        }
      } else {
        auth = "not auth";
      }
    }
  } else {
    saveBoolShare(key: "auth", data: false);
    auth = "not auth";
  }
  // auth = false;
  await Future.delayed(Duration(seconds: 3), () async {
    //load all data here
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("userDetails")) {
      String encodedData = prefs.getString("userDetails");
      var decodedData = json.decode(encodedData);
      print(decodedData);
      userName = decodedData["data"]["name"];
      userPhone = decodedData["data"]["phone"];
      icePrimaryPhone = decodedData["data"]["ice_primary_phone"];
      iceSecondaryPhone = decodedData["data"]["ice_secondary_phone"];
      userRole = decodedData["data"]["role"];
      accessToken = decodedData["data"]["access_token"];
    } else {
      print("please log in");
    }
  });
  return auth;
}
