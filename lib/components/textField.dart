import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/properties.dart';

Widget textFormField({
  @required String hintText,
  String labelText,
  String validateMsg,
  IconData icon,
  int textLength,
  Color iconColor,
  Color cursorColor,
  Color textColor = BLACK,
  @required TextEditingController controller,
  bool validate = true,
  bool suggestion = false,
  TextInputType inputType = TextInputType.text,
  int maxLine = 1,
  int minLine = 1,
  bool validateEmail = false,
  double width,
  enable = true,
  bool removeBorder = false,
  void Function() onIconTap,
  TextInputAction inputAction,
  void Function() onEditingComplete,
  @required FocusNode focusNode,
}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: removeBorder ? 10 : 0),
    decoration: BoxDecoration(
        color: SECONDARYCOLOR, borderRadius: BorderRadius.circular(6)),
    // padding: EdgeInsets.all(3),
    child: TextFormField(
      enabled: enable,
      enableSuggestions: suggestion,
      keyboardType: inputType,
      controller: controller,
      minLines: minLine,
      maxLines: maxLine,
      maxLength: textLength,
      focusNode: focusNode,
      autofocus: false,
      textInputAction: inputAction,
      cursorColor: cursorColor,
      style: TextStyle(
        color: textColor,
      ),
      onEditingComplete: () {
        print(controller.text);
        focusNode.unfocus();
        onEditingComplete();
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: ASHDEEP),
        labelText: labelText,
        labelStyle: TextStyle(color: ASHDEEP),
        suffixIcon: icon == null
            ? null
            : GestureDetector(
                onTap: onIconTap,
                child: Icon(icon, color: iconColor),
              ),
        enabledBorder: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: SECONDARYCOLOR, width: .5),
              ),
        focusedBorder: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: SECONDARYCOLOR, width: .5),
              ),
        border: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: SECONDARYCOLOR, width: .5),
              ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
      validator: (value) {
        RegExp regex = new RegExp(PATTERN);
        if (value.isEmpty && validate) {
          return validateMsg;
        } else if (validateEmail && !regex.hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
    ),
  );
}

Widget textFormField2({
  @required String hintText,
  String labelText,
  String validateMsg,
  IconData icon,
  Color iconColor,
  Color cursorColor,
  Color textColor = BLACK,
  @required TextEditingController controller,
  bool validate = true,
  bool suggestion = false,
  TextInputType inputType = TextInputType.text,
  int maxLine = 1,
  int minLine = 1,
  bool validateEmail = false,
  double width,
  enable = true,
  bool removeBorder = false,
  void Function() onIconTap,
  TextInputAction inputAction,
  void Function() onEditingComplete,
  @required FocusNode focusNode,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20),
    child: TextFormField(
      enabled: enable,
      enableSuggestions: suggestion,
      keyboardType: inputType,
      controller: controller,
      minLines: minLine,
      maxLines: maxLine,
      focusNode: focusNode,
      autofocus: false,
      textInputAction: inputAction,
      cursorColor: cursorColor,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      onEditingComplete: () {
        print(controller.text);
        focusNode.unfocus();
        onEditingComplete();
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: ASHDEEP),
        labelText: labelText,
        labelStyle: TextStyle(color: BLACK),
        suffixIcon: icon == null
            ? null
            : GestureDetector(
                onTap: onIconTap,
                child: Icon(icon, color: iconColor),
              ),
      ),
      validator: (value) {
        RegExp regex = new RegExp(PATTERN);
        if (value.isEmpty && validate) {
          return validateMsg;
        } else if (validateEmail && !regex.hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
    ),
  );
}

Widget textFormFieldSmall({
  // @required String hintText,
  String labelText,
  String validateMsg,
  IconData icon,
  Color iconColor,
  Color cursorColor,
  Color textColor = BLACK,
  @required TextEditingController controller,
  bool validate = true,
  bool suggestion = false,
  TextInputType inputType = TextInputType.text,
  int maxLine = 1,
  int minLine = 1,
  bool validateEmail = false,
  double width,
  enable = true,
  bool removeBorder = false,
  void Function() onIconTap,
  TextInputAction inputAction,
  void Function() onEditingComplete,
  @required FocusNode focusNode,
}) {
  return Container(
    width: width,
    color: SECONDARYCOLOR,
    padding: EdgeInsets.all(3),
    child: TextFormField(
      enabled: enable,
      enableSuggestions: suggestion,
      keyboardType: inputType,
      controller: controller,
      minLines: minLine,
      maxLines: maxLine,
      focusNode: focusNode,
      autofocus: false,
      textInputAction: inputAction,
      cursorColor: cursorColor,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      onEditingComplete: () {
        print(controller.text);
        focusNode.unfocus();
        onEditingComplete();
      },
      decoration: InputDecoration(
        // hintText: hintText,
        hintStyle: TextStyle(color: ASHDEEP),
        labelText: labelText,
        labelStyle: TextStyle(color: ASHDEEP),
        suffixIcon: icon == null
            ? null
            : GestureDetector(
                onTap: onIconTap,
                child: Icon(icon, color: iconColor),
              ),
        enabledBorder: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: SECONDARYCOLOR, width: .5),
              ),
        focusedBorder: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: SECONDARYCOLOR, width: .5),
              ),
        border: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: SECONDARYCOLOR, width: .5),
              ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
      validator: (value) {
        RegExp regex = new RegExp(PATTERN);
        if (value.isEmpty && validate) {
          return validateMsg;
        } else if (validateEmail && !regex.hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
    ),
  );
}
