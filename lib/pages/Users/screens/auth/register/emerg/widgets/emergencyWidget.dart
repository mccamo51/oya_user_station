import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/spec/strings.dart';

Widget emergencyContactWidget({
  @required BuildContext context,
  @required TextEditingController primaryContactController,
  @required TextEditingController secondaryContactController,
  @required Function onCreate,
  @required Function onShowDialog,
  @required FocusNode primaryContactFocusNode,
  @required FocusNode secondaryContactFocusNode,
  @required Key formKey,
}) {
  return Scaffold(
    body: Padding(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Emergency Contact",
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
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  EMERGENCYTEXT,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  newCountrySelect(
                      controller: primaryContactController,
                      hintText: "Primary Emergency Contact*",
                      focus: primaryContactFocusNode),
                  // textFormField(
                  //   controller: primaryContactController,
                  //   focusNode: primaryContactFocusNode,
                  //   hintText: "Primary Emergency Contact*",
                  //   labelText: "Primary Emergency Contact*",
                  //   validateMsg: "Enter primary emergency contact",
                  //   inputType: TextInputType.phone,
                  // ),
                  SizedBox(height: 15),
                  newCountrySelect(
                      controller: secondaryContactController,
                      hintText: "Secondary Emergency Contact",
                      focus: secondaryContactFocusNode),
                  // textFormField(
                  //   controller: secondaryContactController,
                  //   focusNode: secondaryContactFocusNode,
                  //   hintText: "Secondary Emergency Contact",
                  //   labelText: "Secondary Emergency Contact",
                  //   validateMsg: "Enter secondary emergency contact",
                  //   inputType: TextInputType.phone,
                  // ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: primaryButton(
                      onFunction: onCreate,
                      title: "Create Account",
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
