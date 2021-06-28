import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/forgotPass/verifyOtpForgotPass.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/auth/secreteQuestion/secreteWidget/secreteWidget.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:oya_porter/spec/strings.dart';

String onTopPhone;

class SecreteQuestion extends StatefulWidget {
  @override
  _SecreteQuestionState createState() => _SecreteQuestionState();
}

class _SecreteQuestionState extends State<SecreteQuestion> {
  TextEditingController phoneController = TextEditingController();

  FocusNode phoneFocus;
  bool isLoading = false;

  @override
  void initState() {
    phoneFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CupertinoActivityIndicator())
          : secreteWidget(
              context: context,
              onContinue: () =>
                  _onContinue(context: context, phone: phoneController.text),
              phoneNumberController: phoneController,
              phoneNumberFocus: phoneFocus,
            ),
    );
  }

  _onContinue({String phone, BuildContext context}) async {
    try {
      if (phone.isEmpty) {
        wrongPasswordToast(
            msg: "Phone Number required", title: "Required", context: context);
      } else {
        setState(() {
          isLoading = true;
        });

        Map<String, dynamic> body = {
          'phone': phone,
        };
    final url = Uri.parse("$BASE_URL/account/check_phone");

        final response = await http.post(
          url,
          body: json.encode(body),
          headers: {
            "Authorization": "Bearer $accessToken",
            'Content-Type': 'application/json'
          },
        ).timeout(Duration(seconds: 50));
        if (response.statusCode == 200) {
          setState(() {
            isLoading = false;
          });
          final responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            setState(() {
              onTopPhone = phone;
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => VerifyOtpForgotPassword()),
                (Route<dynamic> route) => false);
          } else {
            toastContainer(text: responseData['message']);
          }
        } else if (response.statusCode == 401) {
          sessionExpired(context);
        } else {
          toastContainer(text: "Error has occured");
        }
      }
    } on TimeoutException catch (_) {
      setState(() {
        isLoading = false;
      });
      toastContainer(
        text: CONNECTIONTIMEOUT,
        backgroundColor: RED,
      );
    } on SocketException catch (s) {
      setState(() {
        isLoading = false;
      });
      print(s);
      toastContainer(
        text: INTERNETCONNECTIONPROBLEM,
        backgroundColor: RED,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      toastContainer(
        text: "Error occured. Please try again...$e",
        backgroundColor: RED,
      );
    }
  }
}
