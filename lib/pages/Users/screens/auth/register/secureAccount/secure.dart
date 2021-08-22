import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/customLoading.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/firebase/firebaseAuth.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/verification/verify.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:oya_porter/spec/strings.dart';

import 'widgets/secureWidget.dart';

String userName,
    userPhone,
    icePrimaryPhone,
    iceSecondaryPhone,
    userRole,
    accessToken;

class SecureAccount extends StatefulWidget {
  final String firstName, lastName, phoneNumber, ice1, ice2;

  SecureAccount({
    @required this.firstName,
    @required this.lastName,
    @required this.phoneNumber,
    @required this.ice1,
    @required this.ice2,
  });
  @override
  _SecureAccountState createState() => _SecureAccountState();
}

class _SecureAccountState extends State<SecureAccount> {
  StreamController<ErrorAnimationType> errorController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FireAuth _fireAuth = new FireAuth();

  TextEditingController verificationCodeController = TextEditingController();

  bool hasError = false, _isLoading = false;
  String currentText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        secureWidget(
          context: context,
          onCreate: () => _onVerify(),
          onShowDialog: null,
          errorController: errorController,
          hasError: hasError,
          key: _formKey,
          onChange: (String value) => _onChange(value),
          textEditingController: verificationCodeController,
        ),
        if (_isLoading) customLoadingPage(msg: "")
      ],
    );
  }

  void _onChange(String value) {
    setState(() {
      hasError = false;
      currentText = value;
    });
  }

  void _onVerify() {
    if (currentText.length != 4) {
      setState(() {
        _isLoading = false;
      });
      // Triggering error shake animation
      errorController.add(ErrorAnimationType.shake);
      setState(() {
        hasError = true;
      });
    } else {
      _onCreateAccount();
    }
  }

  _onCreateAccount() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      final url = Uri.parse("$REGISTER_URL");
      try {
        Map<String, dynamic> body = {
          'name': "${widget.firstName} ${widget.lastName}",
          'phone': "${widget.phoneNumber}",
          "ice1_phone": "${widget.ice1}",
          "country_code": countryName,
          "ice2_phone": "${widget.ice2}",
          "pin": "$currentText",
        };
        final response = await http.post(
          url,
          body: json.encode(body),
          headers: {
            "Authorization": "Bearer $accessToken",
            'Content-Type': 'application/json'
          },
        ).timeout(Duration(seconds: 50));
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData["status"] == 200) {
            saveStringShare(key: "userDetails", data: response.body);
            saveBoolShare(key: "auth", data: true);
            userName = responseData["data"]["name"];
            userPhone = responseData["data"]["phone"];
            icePrimaryPhone = responseData["data"]["ice_primary_phone"];
            iceSecondaryPhone = responseData["data"]["ice_secondary_phone"];
            userRole = responseData["data"]["role"];
            accessToken = responseData["data"]["access_token"];
            setState(() => _isLoading = false);
            await _fireAuth.signIn(
                email: "$userPhone@oyaghana.com",
                password: "12345678",
                phone: userPhone);
            toastContainer(
              text: responseData['message'],
              backgroundColor: PRIMARYCOLOR,
            );
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => VerifyNumber()),
                (Route<dynamic> route) => false);
          } else {
            setState(() {
              _isLoading = false;
            });
            toastContainer(
              text: responseData['message'],
              backgroundColor: RED,
            );
          }
        } else {
          final responseData = json.decode(response.body);
          setState(() {
            _isLoading = false;
          });
          toastContainer(
            text: responseData['message'],
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
        print(e);
        toastContainer(
          text: "Error occured. Please try again...$e",
          backgroundColor: RED,
        );
      }
    }
  }
}
