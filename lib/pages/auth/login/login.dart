import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/spec/sharePreference.dart';

import 'loginWidget/loginWidget.dart';

String accessToken;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      loginApi(
          phone: _phoneController.text.trim(),
          password: _passwordController.text.trim());
    }
    _phoneController.clear();
    _passwordController.clear();
  }

  loginApi({
    phone,
    password,
  }) async {
    // // hideKeyboard();
    // phoneFocus.unfocus();
    // pinFocus.unfocus();
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await http.post("$LOGIN_URL", body: {
          'phone': phone,
          'pin': password
        }).timeout(Duration(seconds: 50));
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          saveBoolShare(key: "auth", data: true);
          if (responseData['status'] == 200) {
            saveStringShare(key: "userDetails", data: response.body);
            // setState(() {
            //   print("Success");
            //   userName = responseData["data"]["name"];
            //   userPhone = responseData["data"]["phone"];
            //   icePrimaryPhone = responseData["data"]["ice_primary_phone"];
            //   iceSecondaryPhone = responseData["data"]["ice_secondary_phone"];
            //   userRole = responseData["data"]["role"];
            accessToken = responseData["data"]["access_token"];
            // });

            setState(() {
              _isLoading = false;
            });
            wrongPasswordToast(
                context: context,
                title: "Login Successful",
                msg: responseData['message']);
            navigation(context: context, pageName: "home");
            // if(response["data"]["role"])
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
  // navigation(context: context, pageName: "secrete");
}

// _onLogint(BuildContext context) {
//   navigation(context: context, pageName: "home");
// }
