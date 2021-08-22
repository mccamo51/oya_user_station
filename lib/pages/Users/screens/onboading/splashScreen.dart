import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/navigation.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/secureAccount/secure.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/verification/verify.dart';
import 'package:oya_porter/pages/Users/screens/onboading/onBoardingOne.dart';
import 'package:oya_porter/pages/Users/updateApp/function/checkUpdate.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'functions/checkSession.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _getOtpDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("otpDetails")) {
      String encodeOtp = prefs.getString("otpDetails");
      print(encodeOtp);
      Map<String, dynamic> decodeOtp = json.decode(encodeOtp);
      accessToken = decodeOtp["accessToken"];
    }
  }

  @override
  void initState() {
    super.initState();
    _getOtpDetails();
    //check if user is authenticated
    checkSession().then((status) async {
      print(status);
      if (status != null && status == "auth") {
        checkUpdate(context);
        navigation(context: context, pageName: "home");
      } else if (status != null && status == "otp") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => VerifyNumber()),
            (Route<dynamic> route) => false);
      } else {
        print("Splash");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => OnboardingPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/admin/mainlogo.png",
              height: 150, width: 150),
          // SizedBox(height: 10),
          // Text("$TITLE", style: h3BlueBold),
        ],
      )),
    );
  }
}
