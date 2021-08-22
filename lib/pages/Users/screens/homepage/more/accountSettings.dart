import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/passwordField.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/button.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/styles.dart';

class AccountSettings extends StatefulWidget {
  final String userData;
  AccountSettings({@required this.userData});
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController primaryContactController = TextEditingController();
  TextEditingController secondaryContactController = TextEditingController();
  TextEditingController currentPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  FocusNode fullNameFocus, phoneFocus, primaryContactFocus, secondaryFocus;
  bool _isLoading = false;

  @override
  void initState() {
    var data = json.decode(widget.userData);
    if (widget.userData != null) {
      fullNameController.text = "${data['data']['name']}";
      phoneNumberController.text = "${data['data']['phone']}";
      primaryContactController.text = "${data['data']['ice_primary_phone']}";
      secondaryContactController.text =
          "${data['data']['ice_secondary_phone']}";
    }
    super.initState();
    fullNameFocus = FocusNode();
    phoneFocus = FocusNode();
    primaryContactFocus = FocusNode();
    secondaryFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CupertinoActivityIndicator(radius: 15))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customBack(context, "Account Settings"),
                    SizedBox(height: 15),
                    Text(
                      "Personal Information",
                      style: h3Black,
                    ),
                    SizedBox(height: 20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textFormField(
                            controller: fullNameController,
                            focusNode: fullNameFocus,
                            hintText: "Full Name",
                            labelText: "Full Name",
                          ),
                          SizedBox(height: 15),
                          newCountrySelect(
                              controller: phoneNumberController,
                              hintText: "Phone Number",
                              focus: phoneFocus),
                          SizedBox(height: 20),
                          Text(
                            "Emergency Contacts",
                            style: h3Black,
                          ),
                          SizedBox(height: 15),
                          newCountrySelect(
                              controller: primaryContactController,
                              hintText: "Primary Emergency Contact",
                              focus: primaryContactFocus),
                          SizedBox(height: 15),
                          newCountrySelect(
                              controller: secondaryContactController,
                              hintText: "Secondary Emergency Contact",
                              focus: secondaryFocus),
                          SizedBox(height: 15),
                          SizedBox(
                              width: double.infinity,
                              child: primaryButton(
                                  onFunction: () {
                                    updateUser(
                                        ice1:
                                            "+${countryCode + primaryContactController.text.trim()}",
                                        ice2:
                                            "+${countryCode + secondaryContactController.text.trim()}",
                                        phone:
                                            "+${countryCode + phoneNumberController.text.trim()}",
                                        name: fullNameController.text);
                                  },
                                  title: "Update Details")),
                          SizedBox(height: 20),
                          Text(
                            "Change PIN",
                            style: h3Black,
                          ),
                          SizedBox(height: 20),
                          PasswordField(
                            controller: currentPinController,
                            removeBorder: true,
                            focusNode: null,
                            validate: true,
                            inputType: TextInputType.number,
                            hintText: "Current Pin",
                            labelText: "Current Pin",
                            validateMsg: null,
                          ),
                          SizedBox(height: 15),
                          PasswordField(
                            controller: newPinController,
                            removeBorder: true,
                            focusNode: null,
                            validate: true,
                            inputType: TextInputType.number,
                            hintText: "New Pin",
                            labelText: "New Pin",
                            validateMsg: null,
                          ),
                          SizedBox(height: 15),
                          PasswordField(
                            controller: confirmPinController,
                            removeBorder: true,
                            focusNode: null,
                            validate: true,
                            inputType: TextInputType.number,
                            hintText: "Confirm Pin",
                            labelText: "Confirm Pin",
                            validateMsg: null,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                              width: double.infinity,
                              child: primaryButton(
                                  onFunction: () {
                                    if (currentPinController.text.trim() !=
                                        confirmPinController.text.trim())
                                      wrongPasswordToast(
                                          msg: "Pin does not match",
                                          title: "Mismatch",
                                          context: context);
                                    else
                                      updateUserPin(
                                          newPin: newPinController.text.trim(),
                                          oldPin:
                                              currentPinController.text.trim());
                                  },
                                  title: "Change PIN"))
                        ])
                  ],
                ),
              ),
            ),
    );
  }

  updateUser({String ice1, ice2, name, phone}) async {
    final url = Uri.parse("$UPDATEPROFILE_URL");
    setState(() {
      _isLoading = true;
    });
    final response = await http.put(url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
        body: json.encode(
            {'ice1_phone': '$ice1', 'phone': '$phone', 'name': '$name'}));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        setState(() {
          _isLoading = false;
        });
        toastContainer(text: responseData['message']);
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        toastContainer(text: responseData['message']);
      }
    } else if (response.statusCode == 401) {
      sessionExpired(context);
    } else {
      setState(() {
        _isLoading = false;
      });
      toastContainer(text: "Error has occured");
    }
  }

  updateUserPin({
    String oldPin,
    newPin,
  }) async {
    if (oldPin.isEmpty || newPin.isEmpty) {
      wrongPasswordToast(
          msg: "All fields required", title: "Error", context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      final url = Uri.parse("$UPDATEPIN_URL");

      final response = await http.put(url,
          headers: {
            "Authorization": "Bearer $accessToken",
            'Content-Type': 'application/json'
          },
          body: json.encode({'old_pin': '$oldPin', 'new_pin': '$newPin'}));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 200) {
          setState(() {
            _isLoading = false;
          });
          wrongPasswordToast(msg: responseData['message'], title: "Success");
          Navigator.pop(context);
        }
        {
          setState(() {
            _isLoading = false;
          });
          wrongPasswordToast(
              msg: "User update failed, try again", title: "Failed");
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
