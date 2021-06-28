import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

Future<void> sessionExpired(BuildContext context) async {
  toastContainer(text: "Session Expired, please login again");
  await clearUser(context);
}

Future<void> allPost(
    {Map body,
    String url,
    State state,
    bool isLoad = false,
    BuildContext context}) async {
  final url = Uri.parse("");

  final response = await http.post(
    url,
    body: json.encode(body),
    headers: {
      "Authorization": "Bearer $accessToken",
      'Content-Type': 'application/json'
    },
  ).timeout(
    Duration(seconds: 50),
  );
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    if (responseData['status'] == 200) {
      toastContainer(text: responseData['message']);
      Navigator.pop(context);
    } else {
      toastContainer(text: responseData['message']);
    }
  } else if (response.statusCode == 401) {
    sessionExpired(context);
  } else {
    toastContainer(text: "Error has occured");
  }
}



