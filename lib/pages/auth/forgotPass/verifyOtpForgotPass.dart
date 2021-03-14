import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/forgotPass/widgets/verifyWidget.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/auth/secreteQuestion/secreteQuestion.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/strings.dart';

class VerifyOtpForgotPassword extends StatefulWidget {
  @override
  _VerifyOtpForgotPasswordState createState() =>
      _VerifyOtpForgotPasswordState();
}

class _VerifyOtpForgotPasswordState extends State<VerifyOtpForgotPassword> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  TextEditingController newPinController = TextEditingController();

  FocusNode phoneFocus, otpFocus, newPinFocus;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneFocus = FocusNode();
    otpFocus = FocusNode();
    newPinFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return verifyWidget(
        context: context,
        newPinController: newPinController,
        newPinFocus: newPinFocus,
        onContinue: () => _onContinue(
            context: context,
            pin: newPinController.text,
            otp: otpController.text,
            phone: onTopPhone),
        otpController: otpController,
        otpFocus: otpFocus,
        phoneNumberController: phoneController,
        phoneNumberFocus: phoneFocus);
  }

  _onContinue(
      {String phone, String pin, String otp, BuildContext context}) async {
    print(phone);
    setState(() => _isLoading = true);
    try {
      if (pin.isEmpty) {
        wrongPasswordToast(
            msg: "All Fields are required",
            title: "Required!",
            context: context);
      } else {
        final response = await http.put("$BASE_URL/account/pin/reset", body: {
          'phone': phone,
          'otp': otp,
          'new_pin': pin,
        }).timeout(Duration(seconds: 50));
        if (response.statusCode == 200) {
          setState(() {
            _isLoading = false;
          });
          final responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            toastContainer(text: responseData['message']);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false);
          } else {
            toastContainer(text: responseData['message']);
          }
        }
      }
    } on TimeoutException catch (_) {
      setState(() {
        _isLoading = false;
      });
      toastContainer(
        text: CONNECTIONTIMEOUT,
        backgroundColor: RED,
      );
    } on SocketException catch (s) {
      setState(() {
        _isLoading = false;
      });
      print(s);
      toastContainer(
        text: INTERNETCONNECTIONPROBLEM,
        backgroundColor: RED,
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
      toastContainer(
        text: "Error occured. Please try again...$e",
        backgroundColor: RED,
      );
    }
  }
}
