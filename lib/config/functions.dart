import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

void hideKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.hide');

// void callLauncher(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not open, try different text';
//   }
// }

Future<String> checkSession() async {
  String auth = "not auth";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("auth")) {
    if (prefs.getBool("auth")) {
      auth = "auth";
    } else {
      if (prefs.containsKey("otpPage")) {
        if (!prefs.getBool("otpPage")) {
          auth = "otp";
        }
      } else if (prefs.containsKey("loginPage")) {
        if (!prefs.getBool("loginPage")) {
          auth = "log";
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
  await Future.delayed(Duration(seconds: 2), () async {
    //load all data here
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("userDetails")) {
      String encodedData = prefs.getString("userDetails");
      var decodeData = json.decode(encodedData);
      // print(decodeData['data']['staffs'].length);
      accessToken = decodeData['data']['access_token'];
      stationId = prefs.getString("stationId");
      userName = decodeData["data"]["name"];
      userRole = decodeData["data"]["role"];
      userphone = decodeData["data"]["phone"];
      userICE1 = decodeData["data"]["ice_primary_phone"];
      userICE2 = decodeData["data"]["ice_secondary_phone"];
      // print("--------------------$stationId");
    } else {
      print("please log in now");
    }
  });
  return auth;
}
