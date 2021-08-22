import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/customLoading.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/pages/Users/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:oya_porter/spec/styles.dart';

class VerifyNumber extends StatefulWidget {
  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  final optController = TextEditingController();
  FocusNode optFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    optFocusNode = new FocusNode();
    Map<String, String> optMap = {"accessToken": accessToken};
    saveBoolShare(key: "otpPage", data: false);
    saveStringShare(key: "otpDetails", data: json.encode(optMap));
  }

  @override
  void dispose() {
    super.dispose();
    optFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARYCOLOR,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/checkmark.png"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Almost Ready",
                      style: h3WhiteBold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25),
                      child: Text(
                        "We’ve sent you a One Time Pin to your SMS inbox, enter it below to get started.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: WHITE, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: textFormField(
                          controller: optController,
                          focusNode: optFocusNode,
                          inputType: TextInputType.number,
                          hintText: "One Time Pin",
                          labelText: "One Time Pin",
                          validateMsg: "Enter pin",
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: primaryButton(
                              color: WHITE,
                              title: "Continue",
                              onFunction: () => _onContinue()),
                        ))
                  ],
                ),
              ),
            ),
            if (_isLoading) customLoadingPage()
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _onRendCode,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Didn’t receive it? ',
                      style: TextStyle(color: WHITE),
                    ),
                    TextSpan(
                        text: 'Request another',
                        style: TextStyle(
                          color: WHITE,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _onRendCode()),
                  ]),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _onContinue() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      final url = Uri.parse("$ACCOUT_VERIFY_URL");
      try {
        final response = await http
            .post(url,
                headers: {
                  "Authorization": "Bearer $accessToken",
                  'Content-Type': 'application/json'
                },
                body: json.encode({
                  "code": "${optController.text}",
                }))
            .timeout(Duration(seconds: 50));
        if (response.statusCode == 200) {
          saveBoolShare(key: "otpPage", data: true);
          setState(() => _isLoading = false);
          toastContainer(
            text: "Account created successfully",
            backgroundColor: PRIMARYCOLOR,
          );
          navigation(context: context, pageName: "home");
        } else if (response.statusCode == 401) {
          sessionExpired(context);
        } else {
          setState(() {
            _isLoading = false;
          });
          toastContainer(
            text: "Error occured. Please try again...",
            backgroundColor: RED,
          );
        }
      } on TimeoutException catch (_) {
        setState(() {
          _isLoading = false;
        });
        toastContainer(
          text: CONNECTIONTIMEOUT,
          backgroundColor: RED,
        );
      } on SocketException catch (_) {
        setState(() {
          _isLoading = false;
        });
        toastContainer(
          text: INTERNETCONNECTIONPROBLEM,
          backgroundColor: RED,
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        toastContainer(
          text: "Error occured. Please try again...$e",
          backgroundColor: RED,
        );
      }
    }
  }

  Future<void> _onRendCode() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse("$RESEND_VERIFY_URL");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(
        Duration(seconds: 15),
      );
      final dataResponse = json.decode(response.body);
      if (dataResponse["status"] == 200) {
        setState(() {
          _isLoading = false;
          toastContainer(
            text: dataResponse["message"],
            backgroundColor: PRIMARYCOLOR,
          );
        });
      } else {
        setState(() {
          _isLoading = false;
          toastContainer(
            text: dataResponse["message"],
            backgroundColor: RED,
          );
        });
      }
    } on TimeoutException catch (_) {
      setState(() => _isLoading = false);
      toastContainer(
        text: CONNECTIONTIMEOUT,
        backgroundColor: RED,
      );
    } on SocketException catch (s) {
      print("${s.message}");
      setState(() => _isLoading = false);
      toastContainer(
        text: INTERNETCONNECTIONPROBLEM,
        backgroundColor: RED,
      );
    } catch (e) {
      print("$e");
      setState(() => _isLoading = false);
      toastContainer(
        text: "Error occured. Please try again...$e",
        backgroundColor: RED,
      );
    }
  }
}
