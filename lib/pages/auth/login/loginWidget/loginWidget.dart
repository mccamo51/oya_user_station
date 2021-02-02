import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/passwordField.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

Widget loginWidget({
  @required BuildContext context,
  @required TextEditingController phoneNumberController,
  @required TextEditingController pinController,
  @required FocusNode pinFocusNode,
  @required FocusNode phoneFocusNode,
  @required Function onContinue,
  @required Function onReset,
  @required Key formKey,
}) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 80,
          ),
          Text(
            "Sign In",
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
              "We’ll use these numbers if we need to reach someone",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 40),
          Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textFormField(
                  controller: phoneNumberController,
                  focusNode: phoneFocusNode,
                  inputType: TextInputType.number,
                  hintText: "Phone Number",
                  labelText: "Phone Number"),
              SizedBox(height: 15),
              PasswordField(
                controller: pinController,
                removeBorder: true,
                focusNode: pinFocusNode,
                validate: true,
                inputType: TextInputType.number,
                hintText: "Pin",
                labelText: "Pin",
                validateMsg: null,
              ),
              SizedBox(height: 20),
              FlatButton(
                onPressed: onReset,
                child: Text("I forgot my PIN",
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  child: primaryButton(onFunction: onContinue, title: "Login"))
            ]),
          )
        ]),
      ),
    ),
    // bottomNavigationBar: Container(
    //   height: 50,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       RichText(
    //         text: TextSpan(children: [
    //           TextSpan(
    //             text: 'Don’t have an account? ',
    //             style: TextStyle(color: BLACK),
    //           ),
    //           TextSpan(
    //               text: 'Sign Up',
    //               style: TextStyle(
    //                 color: BLACK,
    //                 decoration: TextDecoration.underline,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //               recognizer: TapGestureRecognizer()
    //                 ..onTap = () {
    //                   // Navigator.push(
    //                   //     context,
    //                   //     MaterialPageRoute(
    //                   //         builder: (BuildContext context) => Register()));
    //                 }),
    //         ]),
    //       )
    //     ],
    //   ),
    // ),
  );
}
