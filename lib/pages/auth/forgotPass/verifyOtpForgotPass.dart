import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/pages/auth/forgotPass/widgets/verifyWidget.dart';
import 'package:oya_porter/pages/auth/login/login.dart';

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
            phone: phoneController.text),
        otpController: otpController,
        otpFocus: otpFocus,
        phoneNumberController: phoneController,
        phoneNumberFocus: phoneFocus);
  }
}

_onContinue(
    {String phone, String pin, String otp, BuildContext context}) async {
  if (pin.isEmpty) {
    wrongPasswordToast(
        msg: "All Fields are required", title: "Required!", context: context);
  } else {
    final response = await http.post("url", body: {
      'phone': phone,
      'otp': otp,
      'new_pin': pin,
    }).timeout(Duration(seconds: 50));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      } else {
        toastContainer(text: responseData['message']);
      }
    }
  }
}
