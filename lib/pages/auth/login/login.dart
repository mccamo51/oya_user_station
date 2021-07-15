import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/config/firebase/firebaseAuth.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/mainHome.dart';
import 'package:oya_porter/spec/sharePreference.dart';

import 'loginWidget/loginWidget.dart';

String accessToken,
    stationId,
    userName,
    userId,
    userRole,
    userphone,
    userICE1,
    userICE2;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FireAuth _fireAuth = new FireAuth();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _phoneController = new TextEditingController();
  final _passwordController = new TextEditingController();

  bool _isLoading = false;

  FocusNode phoneFocus, pinFocus;

  @override
  void initState() {
    pinFocus = FocusNode();
    phoneFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CupertinoActivityIndicator(radius: 15),
            )
          : loginWidget(
              context: context,
              phoneNumberController: _phoneController,
              onContinue: () => _onLogin(),
              onReset: () => _onReset(context),
              pinController: _passwordController,
              phoneFocusNode: phoneFocus,
              pinFocusNode: pinFocus,
              formKey: _formKey,
            ),
    );
  }

  Future<void> _onLogin() async {
    if (_phoneController.text.isEmpty && _passwordController.text.isEmpty) {
      wrongPasswordToast(
          context: context,
          msg: "Phone and Pin required",
          title: "Fields Required");
    } else {
      // print("+" + countryCode + _phoneController.text);
      loginApi(
          phone: ("+" + countryCode + _phoneController.text.trim()),
          password: _passwordController.text.trim());
    }
    // _phoneController.clear();
    // _passwordController.clear();
  }

  loginApi({
    phone,
    password,
  }) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String, dynamic> body = {'phone': phone, 'pin': password};
        final url = Uri.parse("$LOGIN_URL");

        final response = await http.post(
          url,
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json',
          },
        ).timeout(Duration(seconds: 50));
        print(response.body);
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['data']['staffs'].length > 0) {
              setState(() {
                _isLoading = false;
                accessToken = responseData["data"]["access_token"];
                userName = responseData["data"]["name"];
                userphone = responseData["data"]["phone"];
                userICE1 = responseData["data"]["ice_primary_phone"];
                userICE2 = responseData["data"]["ice_secondary_phone"];
                userRole = responseData["data"]["role"];
              });
              await _fireAuth.signIn(
                email: "$phone@gmail.com",
                password: "12345678",
                phone: phone,
              );
              saveBoolShare(key: "auth", data: true);
              saveStringShare(key: "userDetails", data: response.body);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MainHomePage(data: responseData['data']['staffs'])),
                  (route) => false);
              print('===============$stationId========true');
            } else {
              setState(() {
                _isLoading = false;
                wrongPasswordToast(
                    context: context,
                    title: "Login Failed",
                    msg: "User does not have access to this system");
              });
            }
          } else {
            setState(() {
              _isLoading = false;
            });
            wrongPasswordToast(
              context: context,
              title: "Wrong Credientials",
              msg: responseData['message'],
            );
          }
        }
      } on TimeoutException catch (_) {
        setState(() {
          _isLoading = false;
        });
        Platform.isIOS
            ? iosexceptionAlert(
                context: context,
                title: "Connection TimeOut",
                message: "Please check your connection and try again")
            : exceptionAlert(
                context: context,
                title: "Connection TimeOut",
                message: "Please check your connection and try again");
      } on SocketException catch (_) {
        setState(() {
          _isLoading = false;
        });
        Platform.isIOS
            ? iosexceptionAlert(
                context: context,
                title: "No Internet connection",
                message: "Please connection to internet and try again",
              )
            : exceptionAlert(
                context: context,
                title: "No Internet connection",
                message: "Please connection to internet and try again",
              );
      } catch (f) {}
    }
  }
}

_onReset(BuildContext context) {
  navigation(context: context, pageName: "secrete");
}

// _onLogint(BuildContext context) {
//   navigation(context: context, pageName: "home");
// }
