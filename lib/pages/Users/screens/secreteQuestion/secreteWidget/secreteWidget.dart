import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/register.dart';
import 'package:oya_porter/spec/colors.dart';

Widget secreteWidget(
    {@required BuildContext context,
    @required TextEditingController phoneNumberController,
    @required FocusNode phoneNumberFocus,
    @required Function onContinue}) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 80,
          ),
          Text(
            "Secret Question",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              "We’ll send you OTP on this number to verify your account",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 40),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textFormField(
                controller: phoneNumberController,
                focusNode: phoneNumberFocus,
                inputType: TextInputType.number,
                hintText: "Phone Number",
                labelText: "Phone Number"),
            SizedBox(height: 15),
            // PasswordField(
            //   controller: null,
            //   removeBorder: true,
            //   focusNode: null,
            //   validate: true,
            //   inputType: TextInputType.number,
            //   hintText: "What is your In Case of Emergency contact?",
            //   labelText: "What is your In Case of Emergency contact?",
            //   validateMsg: null,
            // ),
            // SizedBox(height: 20),
            primaryButton(onFunction: onContinue, title: "Continue")
          ])
        ]),
      ),
    ),
    bottomNavigationBar: Container(
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Don’t have an account? ',
                style: TextStyle(color: BLACK),
              ),
              TextSpan(
                  text: ' Sign Up',
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
                              builder: (BuildContext context) => Register()));
                    }),
            ]),
          )
        ],
      ),
    ),
  );
}
