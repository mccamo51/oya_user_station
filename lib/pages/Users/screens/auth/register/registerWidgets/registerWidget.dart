import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/strings.dart';

Widget registerWidget({
  @required BuildContext context,
  @required TextEditingController firstNameController,
  @required TextEditingController lastNameController,
  @required TextEditingController phoneNumberController,
  @required FocusNode firstNameFocusNode,
  @required FocusNode lastNameFocusNode,
  @required FocusNode phoneNumberFocusNode,
  @required Function onContinue,
  @required Key formKey,
}) {
  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    SIGNUPTEXT,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    textFormField(
                      controller: firstNameController,
                      focusNode: firstNameFocusNode,
                      hintText: "First Name",
                      labelText: "First Name",
                      validateMsg: "Enter first name",
                    ),
                    SizedBox(height: 10),
                    textFormField(
                      controller: lastNameController,
                      focusNode: lastNameFocusNode,
                      hintText: "Last Name",
                      labelText: "Last Name",
                      validateMsg: "Enter last name",
                    ),
                    SizedBox(height: 10),
                    newCountrySelect(
                        controller: phoneNumberController,
                        hintText: "Phone Number",
                        focus: phoneNumberFocusNode),
                    // textFormField(
                    //   controller: phoneNumberController,
                    //   focusNode: phoneNumberFocusNode,
                    //   hintText: "Phone Number",
                    //   labelText: "Phone Number",
                    //   validateMsg: "Enter your phone number",
                    //   inputType: TextInputType.phone,
                    // ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: primaryButton(
                          onFunction: onContinue, title: "Continue"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
    bottomNavigationBar: Container(
      height: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(color: BLACK),
              ),
              TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    color: BLACK,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    }),
            ]),
          )
        ],
      ),
    ),
  );
}
