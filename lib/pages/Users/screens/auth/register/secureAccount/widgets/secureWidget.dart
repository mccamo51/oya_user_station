import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


Widget secureWidget({
  @required BuildContext context,
  @required StreamController<ErrorAnimationType> errorController,
  @required TextEditingController textEditingController,
  @required Function onCreate,
  @required Function onShowDialog,
  @required bool hasError,
  @required Key key,
  @required void Function(String value) onChange,
}) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Secure Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.info_outline_rounded,
                      color: Colors.red,
                    ),
                    onPressed: onShowDialog,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  "Create a private four-digit pin to secure your account",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 40),
              PinCodeTextField(
                backgroundColor: Colors.transparent,
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v.length < 2) {
                    return "Please enter correct code";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: hasError ? RED : PRIMARYCOLOR.withOpacity(.4),
                  inactiveColor: PRIMARYCOLOR.withOpacity(.4),
                  inactiveFillColor: PRIMARYCOLOR.withOpacity(.4),
                  activeFillColor: PRIMARYCOLOR.withOpacity(.4),
                  selectedFillColor: PRIMARYCOLOR.withOpacity(.4),
                  selectedColor: BLACK,
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                errorAnimationController: errorController,
                // controller: textEditingController,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) => onChange(value),
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                appContext: context,
              ),
              SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: primaryButton(
                  onFunction: onCreate,
                  title: "Create Account",
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
