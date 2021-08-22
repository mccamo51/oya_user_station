import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/styles.dart';

Widget otherPassengerFormDialog({
  @required TextEditingController nameController,
  @required TextEditingController phoneController,
  @required TextEditingController primaryIceNumberController,
  @required FocusNode nameFocusNode,
  @required FocusNode phoneFocusNode,
  @required FocusNode primaryIceNumberFocusNode,
  @required void Function() onAdd,
  @required Key key,
}) {
  return Dialog(
    child: Container(
      padding: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter person's name and phone number to continue",
                style: h3Black,
              ),
              SizedBox(height: 10),
              textFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  hintText: "Enter name",
                  labelText: "Name",
                  validateMsg: "Enter name"),
              SizedBox(height: 10),
              newCountrySelect(
                  controller: phoneController,
                  hintText: "Enter phone number",
                  focus: phoneFocusNode),

              // textFormField(
              //   controller: phoneController,
              //   focusNode: phoneFocusNode,
              //   hintText: "Enter phone",
              //   labelText: "Phone",
              //   validateMsg: "Enter phone",
              //   inputType: TextInputType.phone,
              // ),
              SizedBox(height: 10),
               newCountrySelect(
                  controller: primaryIceNumberController,
                  hintText: "Enter primary ice number",
                  focus: primaryIceNumberFocusNode),

              // textFormField(
              //   controller: primaryIceNumberController,
              //   focusNode: primaryIceNumberFocusNode,
              //   hintText: "Enter primary ice number",
              //   labelText: "Primary ice number",
              //   validate: false,
              // ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: primaryButton(onFunction: onAdd, title: "Add"),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
