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
      // print("--------------------$stationId");
    } else {
      print("please log in now");
    }
  });
  return auth;
}

class TimeAgo {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime notificationDate =
        DateFormat("dd-MM-yyyy h:mma").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
